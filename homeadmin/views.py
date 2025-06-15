from django.contrib.auth.decorators import login_required
from django.shortcuts import render
from django.contrib.auth import logout
from django.shortcuts import redirect

@login_required
def dashboard(request):
    return render(request, 'homeadmin/index.html')

def logout_view(request):
    logout(request)
    return redirect('/')
