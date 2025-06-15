import pickle
import os
import chardet
import io
import pandas as pd
import numpy as np
from django.shortcuts import render
from django.http import JsonResponse
from .models import DataPelatihan
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder
from sklearn.metrics import accuracy_score, confusion_matrix
from sklearn.naive_bayes import CategoricalNB, GaussianNB

# Create your views here.

def index(request):
    akurasi = None
    error = None
    source = None
    split_ratio = None
    data_preview = None
    int_split_input = None

    if request.method == "POST":
        split_input = float(request.POST.get("split", 70)) 
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

        # Label y
        # label_encoder = LabelEncoder()
        # y = label_encoder.fit_transform(y)

        # encoders = {}
        # for col in X.columns:
        #     le = LabelEncoder()
        #     # X_train[col] = le.fit_transform(X_train[col])
        #     # X_test[col] = le.fit_transform(X_test[col])
        #     X[col] = le.fit_transform(X[col])
        #     encoders[col] = le

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
            "Teknik Kendaraan Ringan": 17,
            "Teknik Mesin": 18,
            "Teknik Otomotif": 19,
            "Teknik Pengelasan": 20,
            "Teknik Sepeda Motor": 21,
            "Lainnya": 22,
        }

        jenis_kelamin_map = {
            "Laki-laki": 0,
            "Perempuan": 1,
        }

        data["jurusan"] = data["jurusan"].map(jurusan_map)
        data["jenis_kelamin"] = data["jenis_kelamin"].map(jenis_kelamin_map)
        data.dropna(inplace=True)

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
        model.fit(X_train, y_train)
        train_pred = model.predict(X_train)
        cm = confusion_matrix(y_train, train_pred)
        accuracy = np.trace(cm)/np.sum(cm)
        akurasi = round(accuracy * 100, 2)

        int_split_input = int(split_input)

        import joblib
        from django.conf import settings

        path_model = os.path.join(settings.BASE_DIR, 'tmp', 'model.pkl')
        path_split_data = os.path.join(settings.BASE_DIR, 'tmp', 'split_data.pkl')

        # joblib.dump(model, 'tmp/model.pkl')
        joblib.dump(model, path_model)
        joblib.dump(split_data, "tmp/split_data.pkl")
        
        # print("Kelas jurusan:", encoders['jurusan'].classes_)
        # print("Jumlah kelas jurusan:", len(encoders['jurusan'].classes_))  # Harusnya 23

    return render(request, "pelatihan/index.html", {
        "akurasi": akurasi,
        "error": error,
        "selected_source": source,
        "split_ratio": int_split_input,
        "data_preview": data_preview,})

def get_data_database(request):
    print(">> get_data_database dipanggil")  # Debug

    data_queryset = DataPelatihan.objects.all().values()
    if not data_queryset:
        return JsonResponse({'success': False})
    
    columns = list(data_queryset[0].keys())
    rows = [list(item.values()) for item in data_queryset]

    return JsonResponse({
        'success' : True,
        'columns': columns,
        'rows' : rows
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

# def pelatihan_view(request):
    