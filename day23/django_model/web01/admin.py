# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.contrib import admin
from web01 import models

# Register your models here.

admin.site.register(models.UserInfo)
admin.site.register(models.Article)
admin.site.register(models.Favour)
admin.site.register(models.Host1)
admin.site.register(models.HostAdmin1)

