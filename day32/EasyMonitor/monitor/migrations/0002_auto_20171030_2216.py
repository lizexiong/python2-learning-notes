# -*- coding: utf-8 -*-
# Generated by Django 1.11.4 on 2017-10-30 14:16
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('monitor', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='site',
            name='name',
            field=models.CharField(max_length=64, verbose_name=b'\xe7\xab\x99\xe7\x82\xb9\xe5\x90\x8d'),
        ),
    ]