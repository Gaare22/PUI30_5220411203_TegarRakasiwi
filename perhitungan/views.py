import pandas as pd
from django.shortcuts import render
from .nb_logic import generate_likelihood_table_from_df

# def index(request):
#     return render(request, 'perhitungan/index.html')

# def upload_csv(request):
#     context = {}
#     if request.method == 'POST' and request.FILES.get('file'):
#         file = request.FILES['file']
#         try:
#             df = pd.read_csv(file)
#             expected_cols = [f'P{i}' for i in range(1, 16)] + ['Kelas']
#             if not all(col in df.columns for col in expected_cols):
#                 context['error'] = 'Kolom CSV tidak sesuai format (P1–P15 dan Kelas).'
#             else:
#                 likelihood = generate_likelihood_table_from_df(df)
#                 context['likelihood'] = likelihood
#         except Exception as e:
#             context['error'] = f'Gagal membaca file: {e}'
#     return render(request, 'perhitungan/index.html', context)


def upload_csv(request):
    context = {}
    if request.method == 'POST' and request.FILES.get('file'):
        file = request.FILES['file']

        from io import StringIO

        # Baca byte file, decode dulu, lalu kirim ke pandas
        file_bytes = file.read()

        try:
            decoded_str = file_bytes.decode('latin1')  # Bisa diganti 'utf-8', 'cp1252' kalau perlu
            csv_data = StringIO(decoded_str)
            df = pd.read_csv(csv_data)

            expected_cols = [
                "Jenis Kelamin", "Jurusan",
                "P1", "P2", "P3", "P4", "P5", "P6", "P7", "P8", "P9", "P10",
                "P11", "P12", "P13", "P14", "P15", "Real_Target"
                ]
            if not all(col in df.columns for col in expected_cols):
                context['error'] = 'Kolom CSV tidak sesuai format. Harus mengandung P1–P15 dan Kelas.'
            else:
                likelihood, prior_prob, total_per_Real_Target, total_data = generate_likelihood_table_from_df(df)
                context['likelihood'] = likelihood
                context['prior_prob'] = prior_prob
                context['total_per_Real_Target'] = total_per_Real_Target
                context['total_data'] = total_data
                context['kelas_stats'] = [
                    {
                        'kelas': k,
                        'jumlah': total_per_Real_Target[k],
                        'prior': prior_prob[k]
                    }
                    for k in total_per_Real_Target
                ]

        except Exception as e:
            context['error'] = f'Gagal membaca file CSV: {e}'

    return render(request, 'perhitungan/index.html', context)


