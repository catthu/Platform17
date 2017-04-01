from django.conf.urls import url
from . import views

urlpatterns = [
    url(r'^checkusername/(?P<username>\w+)/$', views.username_exists, name = "checkusername"),
    url(r'^createuser/$', views.create_user, name = "createuser"),
    url(r'^createcharacter/$', views.create_character, name = "createcharacter"),
    url(r'^signin/$', views.sign_in, name ="signin"),
    url(r'^signout/$', views.sign_out, name = "signout"),
]