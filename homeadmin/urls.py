from django.urls import path
from . import views

urlpatterns = [
    path('', views.dashboard, name='homeadmin_dashboard'),
    path('logout/', views.logout_view, name='logout'),
]
