# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.contrib import admin
import models

# Register your models here.

class HostAdmin(admin.ModelAdmin):
    #显示哪些字段
    list_display = ('id','ip_addr','status')

class TemplateAdmin(admin.ModelAdmin):
    #多选框,这两个参数可以多选
    filter_horizontal = ('services','triggers')

class ServiceAdmin(admin.ModelAdmin):
    filter_horizontal = ('items',)
    list_display = ('name','interval','plugin_name')

class TriggerExpressionInline(admin.TabularInline):
    #找到models下面的TriggerExpression表
    model = models.TriggerExpression

class TriggerAdmin(admin.ModelAdmin):
    list_display = ('name','severity','enabled')
    #内联显示，关联哪些表，这些表在admin界面在一个页面显示，在cmdb中有示例
    inlines = [TriggerExpressionInline,]

class TriggerExpressionAdmin(admin.ModelAdmin):
    list_display = ('trigger','service','service_index','specified_index_key','operator_type','data_calc_func','threshold','logic_type')

admin.site.register(models.Host,HostAdmin)
admin.site.register(models.HostGroup)
admin.site.register(models.Template,TemplateAdmin)
admin.site.register(models.Service,ServiceAdmin)
admin.site.register(models.Trigger,TriggerAdmin)
admin.site.register(models.TriggerExpression,TriggerExpressionAdmin)
admin.site.register(models.ServiceIndex)
admin.site.register(models.Action)
admin.site.register(models.ActionOperation)
admin.site.register(models.Maintenance)