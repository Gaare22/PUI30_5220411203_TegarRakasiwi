import os
import joblib
import pandas as pd
import numpy as np
import traceback
import pickle
from pelatihan.models import ModelStorage
from django.shortcuts import render
from django.core.files.storage import FileSystemStorage
from sklearn.naive_bayes import CategoricalNB, GaussianNB
from sklearn.metrics import accuracy_score, confusion_matrix
from sklearn.preprocessing import LabelEncoder
from django.core.files.storage import FileSystemStorage
from django.contrib.auth.decorators import login_required
from django.core.paginator import Paginator
from django.shortcuts import redirect


def load_model_from_db():
    obj = ModelStorage.objects.last()
    if obj is None:
        return None, None, None
    model = pickle.loads(obj.model_blob)
    selected_features = pickle.loads(obj.selected_features)
    split_data = pickle.loads(obj.split_data)

    return model, selected_features, split_data

def index(request):
    # cek session admin
    if "admin_id" not in request.session:
        return redirect("login")  # balik ke halaman login

    context = {
        'data_preview': None,
        'accuracy': None,
        'error': None,
        'selected_source': None,
        'jumlah_data': 0,
        'jumlah_benar': 0,
        'jumlah_salah': 0,
    }

    aksi = request.POST.get('aksi') or request.GET.get('aksi') or 'preview'
    sumber_data = request.POST.get('sumber_data') or request.session.get('sumber_data')
    uploaded_file = request.FILES.get('csv_file')

    if sumber_data:
        context['selected_source'] = sumber_data
        request.session['sumber_data'] = sumber_data  # simpan pilihan di session

    # Ambil model, fitur terpilih, dan split data dari database
    model, selected_features, split_data = load_model_from_db()

    if model is None:
        context['error'] = 'Model belum dilatih atau belum disimpan ke database.'
        return render(request, 'pengujian/index.html', context)

    try:
        #  Ambil data berdasarkan pilihan
        if sumber_data == 'train':
            X = split_data['X_train'][selected_features]
            y = split_data['y_train']

        elif sumber_data == 'test':
            X = split_data['X_test'][selected_features]
            y = split_data['y_test']

        elif sumber_data == 'csv':
            if aksi == 'preview' and uploaded_file:
                df = pd.read_csv(uploaded_file)
                request.session['csv_data'] = df.to_json()
            elif 'csv_data' in request.session:
                df = pd.read_json(request.session['csv_data'])
            else:
                context['error'] = 'Silakan unggah file CSV terlebih dahulu.'
                return render(request, 'pengujian/index.html', context)

            if 'real_target' not in df.columns:
                context['error'] = "Kolom 'real_target' tidak ditemukan pada file CSV."
                return render(request, 'pengujian/index.html', context)
            
            jurusan_map = {...}  # tetap sama
            jenis_kelamin_map = {...}

            df["jurusan"] = df["jurusan"].map(jurusan_map)
            df["jenis_kelamin"] = df["jenis_kelamin"].map(jenis_kelamin_map)


            relevant_columns = split_data['fitur']
            X = df[relevant_columns]
            y = df["real_target"]

        else:
            context['error'] = 'Silakan pilih sumber data.'
            return render(request, 'pengujian/index.html', context)

        # preview dengan pagination
        df_preview = X.copy()

        jenis_kelamin_decode = {
            0: "Laki-laki",
            1: "Perempuan"
        }

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

        jurusan_decode = {v: k for k, v in jurusan_map.items()}

        if "jenis_kelamin" in df_preview.columns:
            df_preview["jenis_kelamin"] = df_preview["jenis_kelamin"].map(jenis_kelamin_decode)

        if "jurusan" in df_preview.columns:
            df_preview["jurusan"] = df_preview["jurusan"].map(jurusan_decode)

        df_preview['real_target'] = y

        df_preview.insert(0, "No", range(1, len(df_preview) + 1))
        records = df_preview.values.tolist()
        columns = df_preview.columns.tolist()

        page_number = request.GET.get('page', 1)
        paginator = Paginator(records, 10)
        page_obj = paginator.get_page(page_number)

        context['columns'] = columns
        context['page_obj'] = page_obj

        if aksi == 'uji':
            # model = joblib.load('tmp/model.pkl')
            y_pred = model.predict(X)

            #penambahan hasil probabilitas perkelas
            if hasattr(model, "predict_proba"):
                y_probs = model.predict_proba(X)
                classes = model.classes_
                for i, cls in enumerate(classes):
                    df_preview[f"prob_{cls}"] = y_probs[:, i].round(3)

            #hasil prediksi
            df_preview["prob_output"] = y_pred

            #hitung akurasi
            cm = confusion_matrix(y, y_pred)
            accuracy = np.trace(cm)/np.sum(cm)
            context['accuracy'] = f"{accuracy * 100:.2f}"

            # Update records & columns agar tabel ikut menampilkan kolom baru
            records = df_preview.values.tolist()
            columns = df_preview.columns.tolist()
            paginator = Paginator(records, 10)
            page_obj = paginator.get_page(page_number)

            context['jumlah_data'] = len(y)
            context['jumlah_benar'] = int((y_pred == y).sum())
            context['jumlah_salah'] = int((y_pred != y).sum())
            context['columns'] = columns
            context['page_obj'] = page_obj

    except Exception as e:
        error_detail = traceback.format_exc()
        print("Error traceback:\n", error_detail)
        context['error'] = f'Terjadi kesalahan saat pengolahan data: {e}'

    return render(request, 'pengujian/index.html', context)
