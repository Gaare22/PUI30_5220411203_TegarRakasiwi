from django.contrib.auth.decorators import login_required
from django.shortcuts import render
from django.contrib.auth import logout
from django.shortcuts import redirect
import json
from .models import DataPelatihanDash, PrediksiGayaBelajarDash
from django.db.models import Count

@login_required
def dashboard(request):

    # cek session admin
    if "admin_id" not in request.session:
        return redirect("login")  # balik ke halaman login

    #Pelatihan
    #jumlah berdasarkan jenis kelamin
    gender_counts_pel = DataPelatihanDash.objects.values('jenis_kelamin').annotate(total=Count('id_pelatihan'))
    label_map = {1: 'Laki-laki', 2: 'Perempuan'}
    gender_labels_pel = [label_map.get(item['jenis_kelamin'], str(item['jenis_kelamin'])) for item in gender_counts_pel]
    gender_data_pel = [item['total'] for item in gender_counts_pel]

    #jumlah berdasarkan real_target (gaya belajar)
    gaya_counts_pel = DataPelatihanDash.objects.values('real_target').annotate(total=Count('id_pelatihan'))
    gaya_labels_pel = [item['real_target'] for item in gaya_counts_pel]
    gaya_data_pel = [item['total'] for item in gaya_counts_pel]

    #jumlah berdasarkan jurusan
    jurusan_counts_pel = DataPelatihanDash.objects.values('jurusan').annotate(total=Count('id_pelatihan'))
    jurusan_labels_pel = [item['jurusan'] for item in jurusan_counts_pel]
    jurusan_data_pel = [item['total'] for item in jurusan_counts_pel]

    #Prediksi
    #jumlah berdasarkan jenis kelamin
    gender_counts_pred = PrediksiGayaBelajarDash.objects.values('jenis_kelamin').annotate(total=Count('id_prediksi'))
    label_map = {1: 'Laki-laki', 2: 'Perempuan'}
    gender_labels_pred = [label_map.get(item['jenis_kelamin'], str(item['jenis_kelamin'])) for item in gender_counts_pred]
    gender_data_pred = [item['total'] for item in gender_counts_pred]

    #jumlah berdasarkan real_target (gaya belajar)
    gaya_counts_pred = PrediksiGayaBelajarDash.objects.values('id_gaya_belajar').annotate(total=Count('id_prediksi'))
    gabel_map = {1: 'Auditor', 2: 'Kinestetik', 3: 'Visual'}
    gaya_labels_pred = [gabel_map.get(item['id_gaya_belajar'], str(item['id_gaya_belajar'])) for item in gaya_counts_pred]
    gaya_data_pred = [item['total'] for item in gaya_counts_pred]

    #jumlah berdasarkan jurusan
    jurusan_counts_pred = PrediksiGayaBelajarDash.objects.values('jurusan').annotate(total=Count('id_prediksi'))
    jurusan_labels_pred = [item['jurusan'] for item in jurusan_counts_pred]
    jurusan_data_pred = [item['total'] for item in jurusan_counts_pred]

    
    context = {
        'gender_labels_pel': gender_labels_pel,
        'gender_data_pel': gender_data_pel,
        'gaya_labels_pel': gaya_labels_pel,
        'gaya_data_pel': gaya_data_pel,
        'jurusan_labels_pel': jurusan_labels_pel,
        'jurusan_data_pel': jurusan_data_pel,
        'gender_labels_pred': gender_labels_pred,
        'gender_data_pred': gender_data_pred,
        'gaya_labels_pred': gaya_labels_pred,
        'gaya_data_pred': gaya_data_pred,
        'jurusan_labels_pred': jurusan_labels_pred,
        'jurusan_data_pred': jurusan_data_pred,
    }
    return render(request, 'homeadmin/index.html', context)

def logout_view(request):
    logout(request)
    return redirect('/')
