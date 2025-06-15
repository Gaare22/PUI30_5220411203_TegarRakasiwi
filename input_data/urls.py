from django.urls import path, include

from . import views

urlpatterns = [
    path('', views.index),
    path('import_csv/', views.import_csv, name='import_csv'),
]