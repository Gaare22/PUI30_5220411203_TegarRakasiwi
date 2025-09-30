import os
import joblib
import pandas as pd
import numpy as np
import traceback
from django.shortcuts import render
from django.core.files.storage import FileSystemStorage
from sklearn.naive_bayes import CategoricalNB, GaussianNB
from sklearn.metrics import accuracy_score, confusion_matrix
from sklearn.preprocessing import LabelEncoder
from django.core.files.storage import FileSystemStorage
from django.contrib.auth.decorators import login_required
from django.core.paginator import Paginator

# Lokasi file split data
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SPLIT_PATH = os.path.join(BASE_DIR, 'tmp/split_data.pkl')

# @login_required
# def index(request):
#     context = {
#         'data_preview': None,
#         'accuracy': None,
#         'error': None,
#         'selected_source': None
#     }

#     if request.method == 'POST':
#         aksi = request.POST.get('aksi', 'preview')
#         sumber_data = request.POST.get('sumber_data')
#         uploaded_file = request.FILES.get('csv_file')
#         context['selected_source'] = sumber_data

#         if not os.path.exists(SPLIT_PATH):
#             context['error'] = 'Model belum dilatih. Silakan lakukan pelatihan terlebih dahulu.'
#             return render(request, 'pengujian/index.html', context)

#         try:
#             split_data = joblib.load('tmp/split_data.pkl')
#             if sumber_data == 'train':
#                 X = split_data['X_train']
#                 y = split_data['y_train']

#             elif sumber_data == 'test':
#                 X = split_data['X_test']
#                 y = split_data['y_test']

#             elif sumber_data == 'csv':
#                 # Saat preview, simpan CSV ke session
#                 if aksi == 'preview':
#                     if not uploaded_file:
#                         context['error'] = 'Silakan unggah file CSV.'
#                         return render(request, 'pengujian/index.html', context)
                    
#                     df = pd.read_csv(uploaded_file)
#                     request.session['csv_data'] = df.to_json()
                
#                 # Saat uji, ambil dari session
#                 elif aksi == 'uji':
#                     if 'csv_data' not in request.session:
#                         context['error'] = 'Silakan unggah file CSV terlebih dahulu.'
#                         return render(request, 'pengujian/index.html', context)
#                     df = pd.read_json(request.session['csv_data'])

#                 # Pastikan kolom target ada
#                 if 'real_target' not in df.columns:
#                     context['error'] = "Kolom 'real_target' tidak ditemukan pada file CSV."
#                     return render(request, 'pengujian/index.html', context)
                
#                 # label_encoder = LabelEncoder()
#                 # df["jenis_kelamin"] = label_encoder.fit_transform(df["jenis_kelamin"])
#                 # df["jurusan"] = label_encoder.fit_transform(df["jurusan"])
                
#                 jurusan_map = {
#                     "Administrasi Perkantoran": 0,
#                     "Akuntansi": 1,
#                     "Bahasa": 2,
#                     "Desain dan Produksi Kriya": 3,
#                     "Desain Komunikasi Visual": 4,
#                     "Desain Pemodelan dan Informasi Bangunan": 5,
#                     "Farmasi": 6,
#                     "IPA": 7,
#                     "IPS": 8,
#                     "KEPERAWATAN": 9,
#                     "Kurikulum Merdeka": 10,
#                     "Multimedia": 11,
#                     "Nautika Kapal Penangkap Ikan": 12,
#                     "Rekayasa Perangkat Lunak": 13,
#                     "Siswa Menengah Pertama": 14,
#                     "Teknik Instalasi Tenaga Listrik": 15,
#                     "Teknik Jaringan Komputer & Telekomunikasi": 16,
#                     "Teknik Kendaraan Ringan Otomotif": 17,
#                     "Teknik Mesin": 18,
#                     "Teknik Pengelasan": 19,
#                     "Teknik Sepeda Motor": 20,
#                     "Lainnya": 21,
#                 }

#                 jenis_kelamin_map = {
#                     "Laki-laki": 0,
#                     "Perempuan": 1,
#                 }

#                 df["jurusan"] = df["jurusan"].map(jurusan_map)
#                 df["jenis_kelamin"] = df["jenis_kelamin"].map(jenis_kelamin_map)

#                 split_data = joblib.load('tmp/split_data.pkl')
#                 relevant_columns = split_data['fitur']

#                 # X = df[["jenis_kelamin","jurusan",'P1', 'P2', 'P3', 'P4', 'P5', 'P6', 'P7', 'P8', 'P9', 'P10', 'P11', 'P12', 'P13', 'P14', 'P15']]
#                 X = df[relevant_columns]
#                 y = df["real_target"]    

#             else:
#                 context['error'] = 'Sumber data tidak valid.'
#                 return render(request, 'pengujian/index.html', context)

#             # Tampilkan data
#             df_preview = X.copy()
#             df_preview['real_target'] = y
#             # context['data_preview'] = df_preview.to_html(classes='table table-bordered', index=False)

#             # context['data_preview'] = X.head(10).to_html(classes='table table-bordered')

#             # konversi DataFrame ke list of dict supaya gampang dipakai di template
#             records = df_preview.values.tolist()
#             columns = df_preview.columns.tolist()

#             # pagination
#             page_number = request.GET.get('page', 1)
#             paginator = Paginator(records, 25)  # tampilkan 10 baris per halaman
#             page_obj = paginator.get_page(page_number)

#             context['columns'] = columns
#             context['page_obj'] = page_obj

#             if aksi == 'uji':
#                 model = joblib.load('tmp/model.pkl')
#                 # model = CategoricalNB()
#                 # model.fit(X, y)
#                 y_pred = model.predict(X)
#                 cm = confusion_matrix(y, y_pred)
#                 # accuracy = accuracy_score(y, y_pred)
#                 accuracy = np.trace(cm)/np.sum(cm)
#                 context['accuracy'] = f"{accuracy * 100:.2f}"

#         except Exception as e:
#             error_detail = traceback.format_exc()
#             print("Error traceback:\n", error_detail)
#             context['error'] = f'Terjadi kesalahan saat pengolahan data: {e}'

#     return render(request, 'pengujian/index.html', context)

@login_required
def index(request):
    context = {
        'data_preview': None,
        'accuracy': None,
        'error': None,
        'selected_source': None
    }

    aksi = request.POST.get('aksi') or request.GET.get('aksi') or 'preview'
    sumber_data = request.POST.get('sumber_data') or request.session.get('sumber_data')
    uploaded_file = request.FILES.get('csv_file')

    if sumber_data:
        context['selected_source'] = sumber_data
        request.session['sumber_data'] = sumber_data  # simpan pilihan di session

    if not os.path.exists(SPLIT_PATH):
        context['error'] = 'Model belum dilatih. Silakan lakukan pelatihan terlebih dahulu.'
        return render(request, 'pengujian/index.html', context)

    try:
        split_data = joblib.load('tmp/split_data.pkl')

        if sumber_data == 'train':
            X = split_data['X_train']
            y = split_data['y_train']

        elif sumber_data == 'test':
            X = split_data['X_test']
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
        df_preview['real_target'] = y
        records = df_preview.values.tolist()
        columns = df_preview.columns.tolist()

        from django.core.paginator import Paginator
        page_number = request.GET.get('page', 1)
        paginator = Paginator(records, 10)
        page_obj = paginator.get_page(page_number)

        context['columns'] = columns
        context['page_obj'] = page_obj

        if aksi == 'uji':
            model = joblib.load('tmp/model.pkl')
            y_pred = model.predict(X)
            cm = confusion_matrix(y, y_pred)
            accuracy = np.trace(cm)/np.sum(cm)
            context['accuracy'] = f"{accuracy * 100:.2f}"

    except Exception as e:
        error_detail = traceback.format_exc()
        print("Error traceback:\n", error_detail)
        context['error'] = f'Terjadi kesalahan saat pengolahan data: {e}'

    return render(request, 'pengujian/index.html', context)
