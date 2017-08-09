# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models

class userinfo(models.Model):
    email = models.EmailField()
    pwd = models.CharField(max_length=32)

