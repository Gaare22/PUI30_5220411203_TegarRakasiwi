import os
import chardet
import io
from django.shortcuts import render
from .models import DataPelatihanInfo, PrediksiGayaBelajarInfo
from django.http import JsonResponse
from django.core.paginator import Paginator
from django.contrib.auth.decorators import login_required

@login_required
def index(request):
    return render(request, 'info_data/index.html')

def get_data_pelatihan(request):
    print(">> get_data_pelatihan dipanggil")  # Debug

    data_queryset = DataPelatihanInfo.objects.all().values()
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

def get_data_prediksi(request):
    print(">> get_data_prediksi dipanggil")  # Debug

    data_queryset = PrediksiGayaBelajarInfo.objects.all().values()
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

    if "id_gaya_belajar_id" in columns:
        idx = columns.index("id_gaya_belajar_id")
        columns[idx] = "Gaya Belajar"

        mapping = {1:"Auditori", 2:"Kinestetik", 3:"Visual"}
        for row in rows:
            row[idx] = mapping.get(row[idx], row[idx])

    return JsonResponse({
        'success' : True,
        'columns': columns,
        'rows' : rows,
        'num_pages': paginator.num_pages,
        'current_page': page_obj.number
    })