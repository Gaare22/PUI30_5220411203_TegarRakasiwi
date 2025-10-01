from django.db import models
# Import langsung model dari app prediksi (supaya tidak duplikat)
from prediksi.models import InputData, GayaBelajar, PrediksiGayaBelajar


# Jika memang butuh model khusus untuk admin (contoh hanya untuk akses),
# gunakan managed = False supaya Django tidak membuat tabel baru.
class InputDataAdmin(InputData):
    class Meta:
        proxy = True   # proxy model, tidak bikin tabel baru
        verbose_name = "Data Pelatihan (Admin)"
        verbose_name_plural = "Data Pelatihan (Admin)"


class GayaBelajarAdmin(GayaBelajar):
    class Meta:
        proxy = True
        verbose_name = "Gaya Belajar (Admin)"
        verbose_name_plural = "Gaya Belajar (Admin)"


class PrediksiGayaBelajarAdmin(PrediksiGayaBelajar):
    class Meta:
        proxy = True
        verbose_name = "Prediksi Gaya Belajar (Admin)"
        verbose_name_plural = "Prediksi Gaya Belajar (Admin)"

    class Meta:
        managed = False
        db_table = 'prediksi_prediksigayabelajar'
