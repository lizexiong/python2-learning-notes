# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models
from web.models import UserProfile

# Create your models here.

class QQGroup(models.Model):
    name = models.CharField(max_length=64,unique=True)
    description = models.CharField(max_length=255,default='Group Description')
    #下面两张表就关联了UserProfile,必须给其中一个起一个别名，不然自动创建第三张表字段的时候会重复，会报错
    members = models.ManyToManyField(UserProfile,blank=True)
    admins = models.ManyToManyField(UserProfile,related_name='group_admins')
    max_member_nums = models.IntegerField(default=20)
    def __unicode__(self):
        return self.name

