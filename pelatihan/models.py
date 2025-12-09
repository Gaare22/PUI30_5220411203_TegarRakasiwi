from django.db import models

class DataPelatihan(models.Model):
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

class ModelStorage(models.Model):
    nama_model = models.CharField(max_length=100, default="model_nb")
    model_blob = models.BinaryField(null=True)               # untuk model
    selected_features = models.BinaryField(null=True)        # list fitur terpilih
    split_data = models.BinaryField(null=True)               # X_train, X_test, y_train, y_test
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.nama_model