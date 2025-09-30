from django.db import models
from prediksi.models import PrediksiGayaBelajar

class InputData(models.Model):
    id_pelatihan = models.AutoField(primary_key=True)
    nama = models.CharField(max_length=200)
    jenis_kelamin = models.CharField(max_length=200)
    jurusan = models.CharField(max_length=200)
    P1 = models.IntegerField()
    P2 = models.IntegerField()
    P3 = models.IntegerField()
    P4 = models.IntegerField()
    P5 = models.IntegerField()
    P6 = models.IntegerField()
    P7 = models.IntegerField()
    P8 = models.IntegerField()
    P9 = models.IntegerField()
    P10 = models.IntegerField()
    P11 = models.IntegerField()
    P12 = models.IntegerField()
    P13 = models.IntegerField()
    P14 = models.IntegerField()
    P15 = models.IntegerField()
    real_target = models.CharField(max_length=15)

    class Meta:
        managed = False  # Jangan biarkan Django mengelola/membuat ulang tabel ini
        db_table = 'data_pelatihan'

    def __str__(self):
        return self.nama
    
class gaya_belajar(models.Model):
    id_gaya_belajar = models.IntegerField(primary_key=True)
    nama_target = models.CharField(max_length=100)
    gambar = models.ImageField(upload_to='gambar_gaya_belajar/')

    class Meta:
        managed = False  # Jangan biarkan Django mengelola/membuat ulang tabel ini
        db_table = 'gaya_belajar'

    def __str__(self):
        return self.nama_target

class PrediksiGayaBelajar(models.Model):
    id_prediksi = models.AutoField(primary_key=True)
    nama = models.CharField(max_length=200)
    usia = models.CharField(max_length=3)
    jenis_kelamin = models.CharField(max_length=200)
    kelas = models.CharField(max_length=200)
    jurusan = models.CharField(max_length=200)
    asal_sekolah = models.CharField(max_length=200)
    P1 = models.IntegerField()
    P2 = models.IntegerField()
    P3 = models.IntegerField()
    P4 = models.IntegerField()
    P5 = models.IntegerField()
    P6 = models.IntegerField()
    P7 = models.IntegerField()
    P8 = models.IntegerField()
    P9 = models.IntegerField()
    P10 = models.IntegerField()
    P11 = models.IntegerField()
    P12 = models.IntegerField()
    P13 = models.IntegerField()
    P14 = models.IntegerField()
    P15 = models.IntegerField()
    id_gaya_belajar = models.IntegerField()
    id_gaya_belajar = models.ForeignKey(gaya_belajar, on_delete=models.CASCADE, db_column='id_gaya_belajar')

    class Meta:
        managed = False  # Jangan biarkan Django mengelola/membuat ulang tabel ini
        db_table = 'prediksi_prediksigayabelajar'

    def __str__(self):
        return self.nama
    
