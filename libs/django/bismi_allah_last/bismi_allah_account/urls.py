#in the name of Allah
#la ilaha illa Allah mohammed rassoul Allah

from django.urls import path
from . import views

urlpatterns = [
    path("", views.bismi_allah, name="bismi_allah"),
    path("la_ilaha_illa_allah", views.la_ilaha_illa_allah, name="la_ilaha_illa_allah"),
    path("login", views.login, name="login"),
    path("register", views.register, name="register")
]

