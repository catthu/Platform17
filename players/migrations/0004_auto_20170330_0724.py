# -*- coding: utf-8 -*-
# Generated by Django 1.10.6 on 2017-03-30 07:24
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('players', '0003_auto_20170330_0424'),
    ]

    operations = [
        migrations.AlterField(
            model_name='player',
            name='first_name',
            field=models.CharField(default=None, max_length=16, null=True),
        ),
        migrations.AlterField(
            model_name='player',
            name='last_name',
            field=models.CharField(default=None, max_length=16, null=True),
        ),
    ]
