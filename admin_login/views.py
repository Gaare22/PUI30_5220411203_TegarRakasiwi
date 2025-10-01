from django.shortcuts import render, redirect
from django.contrib import messages
from .models import AdminUser  # model admin custom kamu

# def login_view(request):
#     if request.method == "POST":
#         username = request.POST.get("username")
#         password = request.POST.get("password")

#         try:
#             admin = AdminUser.objects.get(username=username)
#             if admin.check_password(password):
#                 # simpan session
#                 request.session['admin_id'] = admin.id
#                 request.session.set_expiry(300)  # expire 5 menit

#                 # redirect ke dashboard home_admin
#                 return redirect("homeadmin_dashboard")
#             else:
#                 messages.error(request, "Password salah")
#         except AdminUser.DoesNotExist:
#             messages.error(request, "Username tidak ditemukan")

#     return render(request, "admin_login/index.html")  # halaman login

def login_view(request):
    if request.method == "POST":
        username = request.POST.get("username")
        password = request.POST.get("password")

        try:
            admin = AdminUser.objects.get(username=username)
            if admin.check_password(password):
                # simpan session
                request.session['admin_id'] = admin.id
                request.session.set_expiry(300)  # session habis dalam 5 menit
                print(">>> LOGIN BERHASIL:", request.session['admin_id'])

                # arahkan ke dashboard home_admin
                return redirect("homeadmin_dashboard")
            else:
                messages.error(request, "Password salah")
        except AdminUser.DoesNotExist:
            messages.error(request, "Username tidak ditemukan")

    # kalau GET atau login gagal
    return render(request, "admin_login/index.html")

def logout_view(request):
    # Hapus semua session
    request.session.flush()
    # Balik ke halaman login
    return redirect("login")