# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models

# Create your models here.



class HostGroup(models.Model):
    host_group = models.CharField(max_length=32)
    def __unicode__(self):
        return self.host_group

class HostStatus(models.Model):
    host_status = models.CharField(max_length=32)
    def __unicode__(self):
        return self.host_status

class HostAdmin(models.Model):
    host_admin = models.CharField(max_length=32)
    def __unicode__(self):
        return self.host_admin

class Host(models.Model):
    ip = models.CharField(max_length=32)
    port = models.IntegerField()
    host_group = models.ForeignKey(HostGroup)
    host_status = models.ForeignKey(HostStatus)
    host_admin = models.ForeignKey(HostAdmin)
    def __unicode__(self):
        return self.ip
