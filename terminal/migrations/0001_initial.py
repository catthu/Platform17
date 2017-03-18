# -*- coding: utf-8 -*-
# Generated by Django 1.10.4 on 2017-03-18 06:50
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Character',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=200)),
            ],
        ),
        migrations.CreateModel(
            name='Item',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=200)),
            ],
        ),
        migrations.CreateModel(
            name='Puzzle',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=200)),
                ('difficulty', models.PositiveSmallIntegerField(default=0)),
                ('puzzle_text', models.FileField(upload_to=b'')),
                ('puzzle_hint', models.CharField(max_length=200)),
                ('puzzle_solution', models.CharField(max_length=200)),
                ('puzzle_location', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='terminal.Item')),
            ],
        ),
        migrations.CreateModel(
            name='Room',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=200)),
                ('code_name', models.CharField(max_length=200, null=True)),
                ('description', models.CharField(max_length=500, null=True)),
                ('indoor', models.BooleanField()),
                ('exit', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='terminal.Room')),
            ],
        ),
        migrations.AddField(
            model_name='item',
            name='room',
            field=models.ForeignKey(default=0, on_delete=django.db.models.deletion.CASCADE, to='terminal.Room'),
        ),
        migrations.AddField(
            model_name='character',
            name='room',
            field=models.ForeignKey(default=0, on_delete=django.db.models.deletion.SET_DEFAULT, to='terminal.Room'),
        ),
    ]
