from __future__ import unicode_literals

from django.db import models
from django.contrib.auth.models import User
from generics.models import *

storage_user = User.objects.get(username__iexact = "storage")
platform_room = Room.objects.get(code_name__iexact = "platform17")

class Player(models.Model):
    user = models.ForeignKey(User, on_delete = models.CASCADE, default = storage_user.id)
    first_name = models.CharField(max_length = 16, default = None, null = True)
    last_name = models.CharField(max_length = 16, default = None, null = True)
    location = models.ForeignKey(Room, on_delete = models.SET_DEFAULT, default = platform_room.id)
