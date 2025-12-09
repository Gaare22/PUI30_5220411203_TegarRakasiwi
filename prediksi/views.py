import pandas as pd
import os
import joblib
import re
import pickle
from pelatihan.models import ModelStorage
from django.shortcuts import render
from .models import PrediksiGayaBelajar, GayaBelajar
from django.conf import settings
from django.contrib import messages

#load model, split data, fitur terpilih
def load_model_from_db():
    obj = ModelStorage.objects.last()
    if obj is None:
        return None, None, None
    model = pickle.loads(obj.model_blob)
    selected_features = pickle.loads(obj.selected_features)
    split_data = pickle.loads(obj.split_data)

    return model, selected_features, split_data

def prediksi_view(request):
    if request.method == 'POST':
        # Cek Model Tersedia
        model, selected_features, split_data = load_model_from_db()

        if model is None:
            messages.error(request, "Model belum dibuat. Silakan lakukan pelatihan.")
            return render(request, "prediksi/kuisioner.html")

        try:
            model = model

        except Exception as e:
            messages.error(request, f"Terjadi kesalahan saat memuat model: {str(e)}")
            return render(request, 'prediksi/kuisioner.html')

        # Ambil data dari POST
        nama = request.POST.get('nama')
        usia_str = request.POST.get('usia')

        if not usia_str.isdigit():
            messages.error(request, "Usia hanya boleh berisi angka, tidak boleh huruf atau simbol.")
            return render(request, 'prediksi/kuisioner.html')
        
        usia = int(usia_str)
        jenis_kelamin = request.POST.get('jenis_kelamin')
        kelas_str = request.POST.get('kelas')

        if not kelas_str.isdigit():
            messages.error(request, "Kelas hanya boleh berupa angka 7 sampai 12")
            return render(request, 'prediksi/kuisioner.html')

        kelas = int(kelas_str)
        jurusan = request.POST.get('jurusan')
        asal_sekolah = request.POST.get('asal_sekolah')
        P1 = request.POST.get('P1')
        P2 = request.POST.get('P2')
        P3 = request.POST.get('P3')
        P4 = request.POST.get('P4')
        P5 = request.POST.get('P5')
        P6 = request.POST.get('P6')
        P7 = request.POST.get('P7')
        P8 = request.POST.get('P8')
        P9 = request.POST.get('P9')
        P10 = request.POST.get('P10')
        P11 = request.POST.get('P11')
        P12 = request.POST.get('P12')
        P13 = request.POST.get('P13')
        P14 = request.POST.get('P14')
        P15 = request.POST.get('P15')

        print("DEBUG jurusan dari form:", repr(jurusan))

        # validasi nama
        if not re.match(r'^[A-Za-zÀ-ÖØ-öø-ÿ\s]+$', nama):
            messages.error(request, "Nama hanya boleh berisi huruf dan spasi, tidak boleh angka atau simbol.")
            return render(request, 'prediksi/kuisioner.html')
        
        # validasi usia
        if usia > 18:
            messages.error(request, "Umur Pelajar melewati 18 Tahun. Sistem Hanya digunakan untuk pelajar berusia 12 - 18 Tahun.")
            return render(request, "prediksi/kuisioner.html")
        
        if usia < 12:
            messages.error(request, "Umur Pelajar kurang dari 12 Tahun. Sistem Hanya digunakan untuk pelajar berusia 12 - 18 Tahun.")
            return render(request, "prediksi/kuisioner.html")
        
        # validasi kelas
        if kelas < 7 or kelas > 12:
            messages.error(request, "Kelas hanya boleh berupa angka 7 sampai 12")
            return render(request, 'prediksi/kuisioner.html')
        
        # validasi sekolah
        if not re.match(r'^[A-Za-z0-9À-ÖØ-öø-ÿ\s]+$', asal_sekolah):
            messages.error(request, "Nama sekolah hanya boleh huruf, angka, dan spasi (tanpa simbol)")
            return render(request, 'prediksi/kuisioner.html')
        
        if kelas in [7,8,9]:
            jurusan = "Siswa Menengah Pertama"
        else:
            jurusan = request.POST.get('jurusan')

        #mapping jurusan (Encode)
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
            "Keperawatan": 9,
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

        #mapping jenis kelamin (Encode)
        jenis_kelamin_map = {
            "Laki-laki": 0,
            "Perempuan": 1,
        }

        #encode jurusan dan jenis kelamin
        jurusan_encoded = jurusan_map.get(jurusan, -1)
        jenis_kelamin_encoded = jenis_kelamin_map.get(jenis_kelamin, -1)

        #load selection features
        feature_names = split_data['fitur']

        #fitur fitur yang dijadikan input
        all_fitur_input = [
            jenis_kelamin_encoded,
            jurusan_encoded,
            int(P1), int(P2), int(P3), int(P4), int(P5),
            int(P6), int(P7), int(P8), int(P9), int(P10),
            int(P11), int(P12), int(P13), int(P14), int(P15)
        ]

        #debugg
        print("fitur_input:", all_fitur_input)
        print("jumlah fitur:", len(all_fitur_input))
        print("model expects:", model.n_features_in_)

        #ubah nilai kuisioner menjadi dataframe
        input_df = pd.DataFrame([all_fitur_input], columns=feature_names)

        # Selection Feature
        if selected_features is not None:
            input_selected = input_df[selected_features]
        else:
            selected_features = feature_names
            input_selected = input_df

        # Lakukan prediksi
        hasil = model.predict(input_selected)[0]
        
        if hasil == "Auditori":
            hsl = GayaBelajar.objects.get(id_gaya_belajar=1)

        elif hasil == "Kinestetik":
            hsl = GayaBelajar.objects.get(id_gaya_belajar=2)

        elif hasil == "Visual":
            hsl = GayaBelajar.objects.get(id_gaya_belajar=3)

        # Simpan hasil prediksi
        prediksi = PrediksiGayaBelajar(
            nama=nama,
            usia=usia,
            jenis_kelamin=jenis_kelamin,
            kelas=kelas,
            jurusan=jurusan,
            asal_sekolah=asal_sekolah,
            P1=P1,
            P2=P2,
            P3=P3,
            P4=P4,
            P5=P5,
            P6=P6,
            P7=P7,
            P8=P8,
            P9=P9,
            P10=P10,
            P11=P11,
            P12=P12,
            P13=P13,
            P14=P14,
            P15=P15,
            id_gaya_belajar=hsl,
        )
        prediksi.save()

        #decode int pada isian kuisioner
        skala_mapping = {
            1: "Sangat Tidak Setuju",
            2: "Tidak Setuju",
            3: "Netral",
            4: "Setuju",
            5: "Sangat Setuju"
        }

        #aplikasikan decode
        nilai_P1 = int(request.POST.get('P1', 0))
        jawaban_P1 = skala_mapping.get(nilai_P1, "Tidak Valid")
        nilai_P2 = int(request.POST.get('P2', 0))
        jawaban_P2 = skala_mapping.get(nilai_P2, "Tidak Valid")
        nilai_P3 = int(request.POST.get('P3', 0))
        jawaban_P3 = skala_mapping.get(nilai_P3, "Tidak Valid")
        nilai_P4 = int(request.POST.get('P4', 0))
        jawaban_P4 = skala_mapping.get(nilai_P4, "Tidak Valid")
        nilai_P5 = int(request.POST.get('P5', 0))
        jawaban_P5 = skala_mapping.get(nilai_P5, "Tidak Valid")
        nilai_P6 = int(request.POST.get('P6', 0))
        jawaban_P6 = skala_mapping.get(nilai_P6, "Tidak Valid")
        nilai_P7 = int(request.POST.get('P7', 0))
        jawaban_P7 = skala_mapping.get(nilai_P7, "Tidak Valid")
        nilai_P8 = int(request.POST.get('P8', 0))
        jawaban_P8 = skala_mapping.get(nilai_P8, "Tidak Valid")
        nilai_P9 = int(request.POST.get('P9', 0))
        jawaban_P9 = skala_mapping.get(nilai_P9, "Tidak Valid")
        nilai_P10 = int(request.POST.get('P10', 0))
        jawaban_P10 = skala_mapping.get(nilai_P10, "Tidak Valid")
        nilai_P11 = int(request.POST.get('P11', 0))
        jawaban_P11 = skala_mapping.get(nilai_P11, "Tidak Valid")
        nilai_P12 = int(request.POST.get('P12', 0))
        jawaban_P12 = skala_mapping.get(nilai_P12, "Tidak Valid")
        nilai_P13 = int(request.POST.get('P13', 0))
        jawaban_P13 = skala_mapping.get(nilai_P13, "Tidak Valid")
        nilai_P14 = int(request.POST.get('P14', 0))
        jawaban_P14 = skala_mapping.get(nilai_P14, "Tidak Valid")
        nilai_P15 = int(request.POST.get('P15', 0))
        jawaban_P15 = skala_mapping.get(nilai_P15, "Tidak Valid")

        context = {
            'hasil': hasil,
            'nama': nama,
            'usia': usia,
            'jenis_kelamin': jenis_kelamin,
            'kelas': kelas,
            'jurusan': jurusan,
            'asal_sekolah': asal_sekolah,
            'P1': jawaban_P1,
            'P2': jawaban_P2,
            'P3': jawaban_P3,
            'P4': jawaban_P4,
            'P5': jawaban_P5,
            'P6': jawaban_P6,
            'P7': jawaban_P7,
            'P8': jawaban_P8,
            'P9': jawaban_P9,
            'P10': jawaban_P10,
            'P11': jawaban_P11,
            'P12': jawaban_P12,
            'P13': jawaban_P13,
            'P14': jawaban_P14,
            'P15': jawaban_P15,
            'hasil': hasil,
            'gambar': hsl.gambar.url
        }

        return render(request, 'prediksi/hasil.html', context)
    return render(request, 'prediksi/kuisioner.html')

