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
from django.shortcuts import redirect


# Lokasi file split data
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SPLIT_PATH = os.path.join(BASE_DIR, 'tmp/split_data.pkl')

def index(request):
    # cek session admin
    if "admin_id" not in request.session:
        return redirect("login")  # balik ke halaman login

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
