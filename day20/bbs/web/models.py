# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models
from django.contrib.auth.models import User

# Create your models here.

class Article(models.Model):
    """
    帖子表
    """
    title = models.CharField(u'文章标题',max_length=255,unique=True)
    category = models.ForeignKey("Category",verbose_name=u'板块')
    head_img = models.ImageField(upload_to="static/uploads",null=True)
    content = models.TextField(u"内容")
    author = models.ForeignKey("UserProfile")
    publish_data = models.DateField(auto_now=True)
    #设置帖子是否可以隐藏
    hidden = models.BooleanField(default=False)
    #设置帖子是否置顶
    priority = models.IntegerField(u'优先级',default=1000)
    summary = models.CharField(max_length=255)
    def __unicode__(self):
        return "<%s,author:%s>" %(self.title,self.author)

class Comment(models.Model):
    """
    存储所有的评论
    """
    article = models.ForeignKey("Article")
    #谁评论的，直接关联UserProfile表
    user = models.ForeignKey("UserProfile")
    """
    父评论 parent_comment,把self自己传入进去,关联自己，self和自己的表名都可以，related_name=
    给自己的表起一个别名，在django里面如果自关联如果不定义表别名，那么就会出错，因为它会找到自己，
    然后发现错误，别名不能为自己的表名，也不能为这段代码的字段名。
    parent_comment = models.ForeignKey('Comment',related_name='p_comment',blank=True,null=True)
    """
    parent_comment = models.ForeignKey('self',related_name='p_comment',blank=True,null=True)
    comment = models.CharField(max_length=1000)
    date =models.DateTimeField(auto_now=True)
    def __unicode__(self):
        return "<%s,user:%s>" %(self.comment,self.user)

class ThumbUP(models.Model):
    """
    点赞
    """
    article = models.ForeignKey('Article')
    user = models.ForeignKey('UserProfile')
    date = models.DateTimeField(auto_now=True)
    def __unicode__(self):
        return "<user:%s>" %(self.user)

class Category(models.Model):
    """
    帖子板块
    """
    name = models.CharField(max_length=64,unique=True)
    #一个管理员可以管理多个板块，所以要使用第三张表
    admin = models.ManyToManyField('UserProfile')
    def __unicode__(self):
        return self.name

class UserProfile(models.Model):
    """
    用户信息表
    """
    #这里使用onetoone，在代码上限制，这里的User是django自带的原生的认证表，里面有一些默认字段，与这里的user字段
    #一对一，防止多次选择，如果使用外键，那么原生User表的账户就可以被我的user多次使用，相当于一个账户多人使用。
    #这里的限制就相当于user unique=True不让重复
    user = models.OneToOneField(User)
    name = models.CharField(max_length=32)
    groups = models.ManyToManyField('UserGroup')
    #因为一个好友可以有多个好友，别人也是如此，所以是多对多，self代表关联自己表的意思，别忘了。
    friends = models.ManyToManyField('self',related_name='my_friends')
    def __unicode__(self):
        return self.name

class UserGroup(models.Model):
    """
    用户组
    """
    name = models.CharField(max_length=64,unique=True)
    def __unicode__(self):
        return self.name