# -*- coding: utf-8 -*-
# Generated by Django 1.10.6 on 2017-03-30 04:24
from __future__ import unicode_literals

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('generics', '0006_room_opening_script'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='room',
            name='is_scripted',
        ),
        migrations.RemoveField(
            model_name='room',
            name='opening_script',
        ),
    ]
