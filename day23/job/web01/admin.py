# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.contrib import admin
from web01 import models



# Register your models here.

admin.site.register(models.HostAdmin)
admin.site.register(models.HostGroup)
admin.site.register(models.HostStatus)
admin.site.register(models.Host)
