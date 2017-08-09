# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models

# Create your models here.

class UserList(models.Model):
    email = models.EmailField()
    password = models.CharField(max_length=30)

class HostList(models.Model):
    host = models.CharField(max_length=30)
    port = models.CharField(max_length=30)
    status = models.CharField(max_length=30)
    business = models.CharField(max_length=30)



