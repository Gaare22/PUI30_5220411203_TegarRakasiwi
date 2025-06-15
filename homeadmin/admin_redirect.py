from django.shortcuts import redirect
from django.urls import resolve

class AdminLoginRedirectMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        # Jika user mengakses /admin/ dan sudah login
        if request.path == '/admin/' and request.user.is_authenticated:
            return redirect('/homeadmin/')  # alihkan ke halamanmu

        return self.get_response(request)
