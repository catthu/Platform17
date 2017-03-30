from __future__ import unicode_literals

from django.db import models

# Create your models here.
DEFAULT_ITEM_LOCATION = 5 # Room of Holding (Storage)
DEFAULT_CHARACTER_LOCATION = 4 # Waiting Room (Chargen)

class Room(models.Model):
    name = models.CharField(max_length = 200)
    code_name = models.CharField(max_length = 200, null = True, unique = True)
    opening_script = models.TextField(null = True, default = None)
    description = models.TextField(null = True)
    indoor = models.BooleanField()
    # Name of file in the js directory, not including the .js extension
    js_filename = models.CharField(max_length = 64, default = 'normalroom')
    exit = models.ForeignKey('self', on_delete = models.CASCADE, null = True)

class Item(models.Model):
    name = models.CharField(max_length = 200)
    room = models.ForeignKey("Room", on_delete = models.CASCADE, default = DEFAULT_ITEM_LOCATION )

class Character(models.Model):
    name = models.CharField(max_length = 200)
    room = models.ForeignKey("Room", on_delete = models.SET_DEFAULT, default = DEFAULT_CHARACTER_LOCATION )

class Puzzle(models.Model):
    name = models.CharField(max_length = 200)
    difficulty = models.PositiveSmallIntegerField(default = 0)
    puzzle_text = models.FileField()
    puzzle_hint = models.CharField(max_length = 200)
    puzzle_solution = models.CharField(max_length = 200)
    puzzle_location = models.ForeignKey(Item, on_delete = models.CASCADE)