from __future__ import unicode_literals

from django.db import models
from django.contrib.auth.models import User
from generics.models import *

storage_user = User.objects.get(username__iexact = "storage")

class Player(models.Model):
    user = models.OneToOneField(User, on_delete = models.CASCADE, default = storage_user.id, unique = True)

# This is not kept track at generics.models.Character
# so that generics is self-contained
class PlayerToCharacters(models.Model):
    player = models.OneToOneField(Player, on_delete = models.CASCADE, unique = True)
    character = models.OneToOneField(Character, on_delete = models.CASCADE, unique = True)