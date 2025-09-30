from django.urls import path

from . import views

urlpatterns = [
    path('', views.index),
    path('get_data_pelatihan/', views.get_data_pelatihan, name='get_data_pelatihan'),
    path('get_data_prediksi/', views.get_data_prediksi, name='get_data_prediksi'),
]