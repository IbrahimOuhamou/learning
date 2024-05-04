#in the name of Allah
#la ilaha illa Allah mohammed rassoul Allah
from django.shortcuts import render, HttpResponse
from .models import TodoItem

# Create your views here.
def bismi_allah(request):
    return render(request, "bismi_allah.html")

def bismi_allah_todos(request):
    items = TodoItem.objects.all()
    return render(request, "todos.html", {"todos": items})

