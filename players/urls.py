from django.conf.urls import url
from . import views

urlpatterns = [
    url(r'^checkusername/(?P<username>\w+)/$', views.username_exists, name = "checkusername"),
]