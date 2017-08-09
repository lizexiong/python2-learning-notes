# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.contrib import admin
from web import models
# Register your models here.

#把板块id展示出来使用以下方法
class CategoryAdmin(admin.ModelAdmin):
    list_display = ('id','name')
class ArticleAdmin(admin.ModelAdmin):
    list_display = ('id','title','author','hidden','publish_data')

admin.site.register(models.Article,ArticleAdmin)
admin.site.register(models.Category,CategoryAdmin)
admin.site.register(models.Comment)
admin.site.register(models.ThumbUP)
admin.site.register(models.UserProfile)
admin.site.register(models.UserGroup)