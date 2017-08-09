# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models

# Create your models here.

class User(models.Model):
    username = models.CharField(max_length=32)
    password = models.CharField(max_length=32)

class HostGroup(models.Model):
    groupname = models.CharField(max_length=32)

class Host(models.Model):
    ip = models.CharField(max_length=32)
    port = models.CharField(max_length=32)
    groupname = models.ForeignKey(HostGroup)


