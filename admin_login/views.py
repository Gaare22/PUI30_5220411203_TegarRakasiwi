from django.shortcuts import render, redirect
from django.contrib import messages
from .models import AdminUser

def login_view(request):
    if request.method == "POST":
        username = request.POST.get("username")
        password = request.POST.get("password")

        try:
            admin = AdminUser.objects.get(username=username)
            if admin.check_password(password):
                # simpan session
                request.session['admin_id'] = admin.id
                request.session.set_expiry(300)  # atur session 300 detik atau 5 menit
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
    request.session.flush()    # Hapus semua session 
    return redirect("login")   # Balik ke halaman login