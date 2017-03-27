from django.conf.urls import url
from . import views

urlpatterns = [
    url(r'^$', views.index, name = "index"),
    url(r'^([a-z, A-Z]+)/$', views.room, name = "room"),
]