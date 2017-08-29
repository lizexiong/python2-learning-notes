#! -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models

# Create your models here.

class UserType(models.Model):
    caption = models.CharField(max_length=32)

class UserList(models.Model):
    username = models.CharField(max_length=32)
    age = models.IntegerField()
    user_type = models.ForeignKey(UserType)


class UserInfo(models.Model):
    username = models.CharField(max_length=32)
    password = models.CharField(max_length=32)
    def __unicode__(self):
        return self.username

class Article(models.Model):
    title = models.CharField(max_length=32)
    content = models.CharField(max_length=1000)
    def __unicode__(self):
        return self.title

class Favour(models.Model):
    user_obj = models.ForeignKey(UserInfo)
    article_obj = models.ForeignKey(Article)
    def __unicode__(self):
        return ("%s---->%s")%(self.user_obj.username,self.article_obj.title)



class Host(models.Model):
    ip = models.CharField(max_length=24)
    port = models.IntegerField()
    def __unicode__(self):
        return self.ip

class HostAdmin(models.Model):
    username = models.CharField(max_length=32)
    email = models.EmailField(max_length=32)
    host = models.ManyToManyField(Host)
    def __unicode__(self):
        return self.username

class Host1(models.Model):
    ip = models.CharField(max_length=24)
    port = models.IntegerField()
    def __unicode__(self):
        return self.ip

class HostAdmin1(models.Model):
    username = models.CharField(max_length=32)
    email = models.EmailField(max_length=32)
    host = models.ManyToManyField(Host1,through='HostRelation')
    def __unicode__(self):
        return self.username

class HostRelation(models.Model):
    c1 = models.ForeignKey(Host1)
    c2 = models.ForeignKey(HostAdmin1)



















