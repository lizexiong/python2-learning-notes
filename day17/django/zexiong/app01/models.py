# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models

# Create your models here.

class userinfo(models.Model):
    #如果没有models.AutoField,默认会创建一个id的自增列
    email = models.EmailField()
    pwd = models.CharField(max_length=30)
    memo = models.TextField()

