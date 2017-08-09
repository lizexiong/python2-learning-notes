# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models

# Create your models here.

class Group2(models.Model):
    caption = models.CharField(max_length=32)

class User2(models.Model):
    username = models.CharField(max_length=32)
    group2 = models.ForeignKey('Group2')
