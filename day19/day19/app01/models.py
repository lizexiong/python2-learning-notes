# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models

# Create your models here.

class UserInfo(models.Model):
    name = models.CharField(max_length=32)
    ctime = models.DateTimeField(auto_now=True)
    #auto_now = Ture,自动记录创建时间
    uptime = models.DateTimeField(auto_now_add=True)
    #auto_now_add=True自动记录更新时间
    email = models.EmailField(max_length=32,null=True)
    #这里email其实后台也是字符串，只不过是后台还用一个正则表达来匹配罢了。
    email2 = models.EmailField(max_length=32,default='zexiong@huawei.com')
    ip = models.GenericIPAddressField(protocol="ipv4",null=True,blank=True)
    #这里后台其实也是字符串，后台使用正则做匹配,blank=true就是可以在admin界面输入为空
    img = models.ImageField(null=True,blank=True,upload_to="upload")
    #这里upload_to就是图片上传路径。

    def __unicode__(self):
        return self.name


class HostType(models.Model):
    HostType = models.CharField(max_length=32)

class HostColor(models.Model):
    nid = models.ImageField(unique=True)
    HostColor = models.CharField(max_length=32)
    HostTest = models.CharField(max_length=32)

class Host(models.Model):
    HostIP = models.CharField(max_length=32)
    HostType = models.ForeignKey(HostType)
    HostColor = models.ForeignKey(HostColor,to_field='nid')

class UserGroup(models.Model):
    group_name = models.CharField(max_length=32)

class User(models.Model):
    name = models.CharField(max_length=32)
    phone = models.CharField(max_length=32)
    User_And_UserGroup = models.ManyToManyField('UserGroup')

class User2(models.Model):
    name = models.CharField(max_length=32)
    phone = models.CharField(max_length=32)

class IsLogin(models.Model):
    islogin = models.CharField(max_length=32)
    user2_and_islogin = models.OneToOneField('User2')

class SimpleModel(models.Model):
    username = models.CharField(max_length=32)
    password = models.CharField(max_length=32)


class Vip(models.Model):
    vip = models.CharField(max_length=32)

class UserGroupNew(models.Model):
    caption = models.CharField(max_length=32)
    vip = models.ForeignKey(Vip,null=True)

class UserNew(models.Model):
    username = models.CharField(max_length=32)
    usergroup = models.ForeignKey(UserGroupNew)


