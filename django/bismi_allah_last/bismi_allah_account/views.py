#in the name of Allah
#la ilaha illa Allah mohammed rassoul Allah
from django.shortcuts import render, HttpResponse

# Create your views here.
def bismi_allah(request):
    return render(request, "bismi_allah.html")

