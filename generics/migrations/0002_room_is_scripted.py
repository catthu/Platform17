# -*- coding: utf-8 -*-
# Generated by Django 1.10.4 on 2017-03-18 06:58
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('generics', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='room',
            name='is_scripted',
            field=models.BooleanField(default=False),
        ),
    ]
