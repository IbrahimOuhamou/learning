#in the name of Allah
#la ilaha illa Allah mohammed rassoul Allah
from django.shortcuts import render, HttpResponse

# Create your views here.
def bismi_allah(request):
    return render(request, "bismi_allah.html")

def la_ilaha_illa_allah(request):
    return render(request, "la_ilaha_illa_allah.html")

def login(request):
    if 'POST' != request.method or not request.POST:
        return render(request, "login.html")
    
    return render(request, "login_request.html")

def register(request):
    return render(request, "register.html")

