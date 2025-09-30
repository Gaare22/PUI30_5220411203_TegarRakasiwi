from django.db import models

# Import langsung model dari app pelatihan (supaya tidak duplikat)
from pelatihan.models import DataPelatihan
from prediksi.models import PrediksiGayaBelajar

class DataPelatihanInfo(DataPelatihan):
    class Meta:
        proxy = True
        verbose_name = "Data Pelatihan (Info Data)"
        verbose_name_plural = "Data Pelatihan (Info Data)"
        managed = False
        db_table = 'data_pelatihan'

class PrediksiGayaBelajarInfo(PrediksiGayaBelajar):
    class Meta:
        proxy = True
        verbose_name = "Prediksi Gaya Belajar (Info)"
        verbose_name_plural = "Prediksi Gaya Belajar (Info)"
        managed = False
        db_table = 'prediksi_prediksigayabelajar'