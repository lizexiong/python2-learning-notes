# -*- coding: utf-8 -*-
# Generated by Django 1.11.2 on 2017-07-16 09:06
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('app01', '0008_simplemodel'),
    ]

    operations = [
        migrations.CreateModel(
            name='UserGroupNew',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('caption', models.CharField(max_length=32)),
            ],
        ),
        migrations.CreateModel(
            name='UserNew',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('username', models.CharField(max_length=32)),
                ('usergroup', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='app01.UserGroupNew')),
            ],
        ),
    ]
