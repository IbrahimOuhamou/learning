#in the name of Allah
#la ilaha illa Allah mohammed rassoul Allah

from django.urls import path
from . import views

urlpatterns = [
    path("", views.bismi_allah, name="bismi_allah")
]

