from django.shortcuts import redirect
from django.urls import reverse

class AdminLoginRequiredMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        # URL yang tidak perlu login
        allowed_paths = [
            reverse("login"),
            "/",              # halaman root
            "/prediksi/",     # halaman prediksi publik
            "/media/",
            "/media/gambar_gaya_belajar/",
            "/admin/",
            "/perhitungan/",
        ]

        # lewati semua file media
        if request.path.startswith("/media/"):
            return self.get_response(request)

        # Kalau request path ada di allowed → lewati
        if request.path in allowed_paths:
            return self.get_response(request)

        # Cek session admin_id
        if "admin_id" not in request.session:
            return redirect("login")

        return self.get_response(request)
