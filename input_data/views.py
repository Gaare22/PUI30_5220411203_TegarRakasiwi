from django.shortcuts import render, redirect
from .forms import InputDataForm
from django.contrib import messages
from django.http import HttpResponseRedirect
import csv
from .models import InputData

# Create your views here.
def index(request):
    # cek session admin
    if "admin_id" not in request.session:
        return redirect("login")  # balik ke halaman login

    if request.method == 'POST':
        form = InputDataForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, "Data berhasil disimpan.")
            return HttpResponseRedirect('/input_data')
        else:
            messages.error(request, 'Gagal Input Data')
        
    else:
        form = InputDataForm()

    return render(request, 'input_data/index.html', {'form': form})

def import_csv(request):
    if request.method == 'POST' and request.FILES.get('csv_file'):
        try:
            csv_file = request.FILES['csv_file']
            decoded_file = csv_file.read().decode('utf-8-sig').splitlines()
            reader = csv.DictReader(decoded_file)
            print("CSV Header:", reader.fieldnames)

            for row in reader:
                InputData.objects.create(
                    nama = row['nama'],
                    jenis_kelamin = row['jenis_kelamin'],
                    jurusan = row['jurusan'],
                    P1 = int(row['P1']),
                    P2 = int(row['P2']),
                    P3 = int(row['P3']),
                    P4 = int(row['P4']),
                    P5 = int(row['P5']),
                    P6 = int(row['P6']),
                    P7 = int(row['P7']),
                    P8 = int(row['P8']),
                    P9 = int(row['P9']),
                    P10 = int(row['P10']),
                    P11 = int(row['P11']),
                    P12 = int(row['P12']),
                    P13 = int(row['P13']),
                    P14 = int(row['P14']),
                    P15 = int(row['P15']),
                    real_target = row['real_target'],
                )
            messages.success(request, 'Data dari CSV berhasil diimpor.')
        except Exception as e:
            messages.error(request, f'Gagal mengimpor CSV: {e}')

        return HttpResponseRedirect('/input_data')

    return HttpResponseRedirect('/input_data')