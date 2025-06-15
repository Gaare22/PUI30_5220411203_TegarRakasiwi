from django.urls import path

from . import views

urlpatterns = [
    path('', views.index),
    path('get_data_database/', views.get_data_database, name='get_data_database'),
    path('upload_csv/', views.upload_csv_view, name='upload_csv'),
]