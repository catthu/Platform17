# -*- coding: utf-8 -*-
from __future__ import unicode_literals
from django.db import migrations, models    

class Migration(migrations.Migration):   

    dependencies = [
        ('generics', '0007_auto_20170330_0424'), # no .py
    ]        

    operations = [
        migrations.AddField(
            model_name='room',
            name='opening_script',
            field=models.TextField(null=True, default = None),
        ),

        migrations.AlterField(
            model_name = 'room',
            name = 'description',
            field = models.TextField(null = True)
        ),
    ]