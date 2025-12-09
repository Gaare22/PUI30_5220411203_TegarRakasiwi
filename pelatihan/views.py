import pickle
import os
import chardet
import io
import pandas as pd
import numpy as np
import joblib
import pickle
from .models import ModelStorage
from .nb_logic import generate_likelihood_table_from_df
from django.shortcuts import render
from django.http import JsonResponse
from .models import DataPelatihan
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder
from sklearn.metrics import accuracy_score, confusion_matrix
from sklearn.naive_bayes import CategoricalNB, GaussianNB
from django.core.paginator import Paginator
from django.shortcuts import redirect
from django.conf import settings
from mlxtend.feature_selection import SequentialFeatureSelector as SFS
from sklearn.model_selection import cross_val_score
from sklearn.model_selection import StratifiedKFold

import os
from django.conf import settings

def save_split_to_csv(X_train, X_test, y_train, y_test,
                      jurusan_decode, jenis_kelamin_decode):
    """
    Menggabungkan kembali fitur + target,
    melakukan decode kolom kategorikal,
    lalu menyimpan hasilnya ke folder tmp/ sebagai CSV.
    """

    # Gabungkan fitur dan target
    train_df = X_train.copy()
    train_df["real_target"] = y_train.values

    test_df = X_test.copy()
    test_df["real_target"] = y_test.values

    # Decode kembali
    train_df["jurusan"] = train_df["jurusan"].map(jurusan_decode)
    test_df["jurusan"] = test_df["jurusan"].map(jurusan_decode)

    train_df["jenis_kelamin"] = train_df["jenis_kelamin"].map(jenis_kelamin_decode)
    test_df["jenis_kelamin"] = test_df["jenis_kelamin"].map(jenis_kelamin_decode)

    # Tentukan lokasi folder tmp
    train_path = os.path.join(settings.BASE_DIR, "tmp", "data_pelatihan.csv")
    test_path = os.path.join(settings.BASE_DIR, "tmp", "data_pengujian.csv")

    # Simpan CSV
    train_df.to_csv(train_path, index=False, encoding="utf-8-sig")
    test_df.to_csv(test_path, index=False, encoding="utf-8-sig")

    return train_path, test_path


# Create your views here.
def index(request):
    # cek session admin
    if "admin_id" not in request.session:
        return redirect("login")  # balik ke halaman login

    akurasi = None
    error = None
    source = None
    split_ratio = None
    data_preview = None
    int_split_input = None
    prob_info = None
    selected_features = None

    if request.method == "POST":
        split_input = float(request.POST.get("split", 80)) 
        split_ratio = split_input / 100
        source = request.POST.get("source")  # 'csv' atau 'database'

        if not source:
            error = "Silakan pilih sumber data terlebih dahulu."
            return render(request, "pelatihan/index.html", {"akurasi": None, "error": error})

        # Ambil data berdasarkan sumber
        if source == "csv":
            if 'csv_data' not in request.session:
                error = "Data CSV belum diunggah atau tidak ditemukan dalam sesi."
                return render(request, "pelatihan/index.html", {"akurasi": None, "error": error})
            data = pd.read_json(request.session['csv_data'])
        elif source == "database":
            queryset = DataPelatihan.objects.all().values()
            if not queryset.exists():
                error = "Tidak ada data pelatihan dalam database."
                return render(request, "pelatihan/index.html", {"akurasi": None, "error": error})
            data = pd.DataFrame(list(queryset)).sort_values(by='id_pelatihan')
        else:
            error = "Sumber data tidak valid."
            return render(request, "pelatihan/index.html", {"akurasi": None, "error": error})
        
        data_preview = data.to_html(classes="table table-bordered", index=False)
        
        if 'real_target' not in data.columns:
            error = "Kolom 'real_target' tidak ditemukan dalam data."
            return render(request, "pelatihan/index.html", {"akurasi": None, "error": error})

        jurusan_map = {
            "Administrasi Perkantoran": 0,
            "Akuntansi": 1,
            "Bahasa": 2,
            "Desain dan Produksi Kriya": 3,
            "Desain Komunikasi Visual": 4,
            "Desain Pemodelan dan Informasi Bangunan": 5,
            "Farmasi": 6,
            "IPA": 7,
            "IPS": 8,
            "KEPERAWATAN": 9,
            "Kurikulum Merdeka": 10,
            "Multimedia": 11,
            "Nautika Kapal Penangkap Ikan": 12,
            "Rekayasa Perangkat Lunak": 13,
            "Siswa Menengah Pertama": 14,
            "Teknik Instalasi Tenaga Listrik": 15,
            "Teknik Jaringan Komputer & Telekomunikasi": 16,
            "Teknik Kendaraan Ringan Otomotif": 17,
            "Teknik Mesin": 18,
            "Teknik Pengelasan": 19,
            "Teknik Sepeda Motor": 20,
            "Lainnya": 21,
        }

        jenis_kelamin_map = {
            "Laki-laki": 0,
            "Perempuan": 1,
        }

        # bikin reverse mapping: angka → label
        jurusan_decode = {v: k for k, v in jurusan_map.items()}
        jenis_kelamin_decode = {v: k for k, v in jenis_kelamin_map.items()}

        # Cek baris yang memiliki nilai kosong di kolom penting
        print("Jumlah data awal:", len(data))
        kolom_kritis = ["jenis_kelamin", "jurusan"] + [f"P{i}" for i in range(1, 16)] + ["real_target"]
        missing = data[data[kolom_kritis].isnull().any(axis=1)]
        print("Jumlah data mengandung NaN:", len(missing))
        print("Kolom yang bermasalah:\n", data.isnull().sum()[data.isnull().sum() > 0])
        print("Contoh data kosong:\n", missing.head(10))

        data["jurusan"] = data["jurusan"].map(jurusan_map)
        data["jenis_kelamin"] = data["jenis_kelamin"].map(jenis_kelamin_map)

        print(data.isnull().sum()[data.isnull().sum() > 0])
        baris_nan = data[data.isnull().any(axis=1)]
        print('aaaa',baris_nan)
        # Berdasarkan nama kolom
        # print(data['jurusan'].value_counts())

        X = data[["jenis_kelamin","jurusan","P1", "P2", "P3", "P4", "P5", "P6", "P7", "P8", "P9", "P10", "P11", "P12", "P13", "P14", "P15"]]
        y = data["real_target"]

        relevant_columns = [
        "jenis_kelamin", "jurusan",
        "P1", "P2", "P3", "P4", "P5", "P6", "P7", "P8", "P9", "P10",
        "P11", "P12", "P13", "P14", "P15"
        ]

        # Split data
        X_train, X_test, y_train, y_test = train_test_split(X, y, train_size=split_ratio, random_state=42, shuffle=True, stratify=y)

        # Panggil fungsi untuk menggabungkan kembali fitur dan target untuk disimpan ke CSV
        train_path, test_path = save_split_to_csv(
            X_train, X_test, y_train, y_test,
            jurusan_decode, jenis_kelamin_decode
        )

        print(f" Data pelatihan disimpan ke: {train_path}")
        print(f" Data pengujian disimpan ke: {test_path}")

        # Simpan hasil split sementara
        split_data = {
            "X_train": X_train,
            "X_test": X_test,
            "y_train": y_train,
            "y_test": y_test,
            # 'fitur': list(X_train.columns),
            # 'encoders': encoders,
            'fitur': relevant_columns
        }

        # pelatihan model    
        model = CategoricalNB()

        # Selection Feature
        sfs = SFS(
            model,
            k_features='best',      # pilih jumlah fitur terbaik otomatis
            forward=True,           # True: forward selection, False: backward elimination
            floating=False,         # kalau True = SFFS (lebih fleksibel)
            scoring='accuracy',
            cv=5,                   # 5-fold cross validation
            n_jobs=-1,              # gunakan semua core CPU
        )

        # Jalankan seleksi fitur
        sfs = sfs.fit(X_train, y_train)

        # Fitur terpilih
        selected_features = list(sfs.k_feature_names_)
        print("Fitur terpilih:", selected_features)

        # Gunakan hanya fitur terpilih untuk training ulang model
        X_train_selected = X_train[selected_features]
        X_test_selected = X_test[selected_features]

        # Latih model dengan fitur terpilih
        model.fit(X_train_selected, y_train)
        train_pred = model.predict(X_train_selected)

        cm = confusion_matrix(y_train, train_pred)
        accuracy = np.trace(cm)/np.sum(cm)
        akurasi = round(accuracy * 100, 2)

        int_split_input = int(split_input)

        path_model = os.path.join(settings.BASE_DIR, 'tmp', 'model.pkl')
        path_split_data = os.path.join(settings.BASE_DIR, 'tmp', 'split_data.pkl')
        path_features = os.path.join(settings.BASE_DIR, 'tmp', 'selected_features.pkl')

        # # joblib.dump(model, 'tmp/model.pkl')
        # joblib.dump(model, path_model)
        # joblib.dump(selected_features, path_features)
        # joblib.dump(split_data, "tmp/split_data.pkl")

        # Serialize objek menjadi bytes
        model_blob = pickle.dumps(model)
        features_blob = pickle.dumps(selected_features)
        split_blob = pickle.dumps(split_data)

        train_df = X_train.copy()
        train_df['real_target'] = y_train.values

        prior_prob, total_per_kelas, total_data, jenis_kelamin_rows, jurusan_rows, pertanyaan_rows = generate_likelihood_table_from_df(
            train_df,
            jurusan_decode=jurusan_decode,
            jenis_kelamin_decode=jenis_kelamin_decode
        )
                
        prob_info = {
            "prior_prob": prior_prob,
            "total_per_Real_Target": total_per_kelas,
            "total_data": total_data,
            "jenis_kelamin": jenis_kelamin_rows,
            "jurusan": jurusan_rows,
            "pertanyaan": pertanyaan_rows,
            "kelas_stats": [
                {"kelas": k, "jumlah": total_per_kelas[k], "prior": prior_prob[k]}
                for k in total_per_kelas
            ]
        }

         # Simpan ke database
        ModelStorage.objects.create(
            model_blob=model_blob,
            selected_features=features_blob,
            split_data=split_blob
        )

    return render(request, "pelatihan/index.html", {
        "akurasi": akurasi,
        "error": error,
        "selected_source": source,
        "split_ratio": int_split_input,
        "data_preview": data_preview,
        "prob_info": prob_info,
        "selected_features": selected_features,
        })

def get_data_database(request):
    print(">> get_data_database dipanggil")  # Debug

    data_queryset = DataPelatihan.objects.all().values()
    if not data_queryset:
        return JsonResponse({'success': False})
    
    # columns = list(data_queryset[0].keys())
    # rows = [list(item.values()) for item in data_queryset]

    # Ambil parameter halaman dari query string (?page=2)
    page_number = request.GET.get("page", 1)
    paginator = Paginator(list(data_queryset), 25)  # 25 data per halaman

    page_obj = paginator.get_page(page_number)

    columns = list(data_queryset[0].keys())
    rows = [list(item.values()) for item in page_obj.object_list]

    return JsonResponse({
        'success' : True,
        'columns': columns,
        'rows' : rows,
        'num_pages': paginator.num_pages,
        'current_page': page_obj.number
    })

def upload_csv_view(request):
    if request.method == 'POST' and request.FILES.get('file'):
        try:
            raw_data = request.FILES['file'].read()

            # Deteksi encoding
            result = chardet.detect(raw_data)
            encoding = result['encoding'] or 'utf-8'

            # Baca ulang dengan encoding terdeteksi
            decoded_file = raw_data.decode(encoding)
            df = pd.read_csv(io.StringIO(decoded_file))

            # Simpan ke session
            request.session['csv_data'] = df.to_json()

            columns = list(df.columns)
            rows = df.head(20).values.tolist()

            return JsonResponse({
                'success': True,
                'columns': columns,
                'rows': rows
            })

        except Exception as e:
            return JsonResponse({'success': False, 'error': str(e)})
    return JsonResponse({'success': False, 'error': 'Invalid request'})
    