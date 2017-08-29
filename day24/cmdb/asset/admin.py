# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.contrib import admin
from asset import models
from asset.user_admin import UserAdmin
from asset.user_models import UserProfile
from django.contrib.auth.models import Group
from django.contrib.auth.forms import ReadOnlyPasswordHashField



# from django.contrib.auth import  forms as auth_form





class BaseAdmin(object):
    """自定义admin类"""


    choice_fields = []
    fk_fields = []
    dynamic_fk = None
    dynamic_list_display = []
    dynamic_choice_fields = []
    m2m_fields = []



class ServerInline(admin.TabularInline):
    #扎到models的server关联
    model = models.Server
    #这里排除掉，不显示谁
    exclude = ('memo',)
    #只读选项
    #readonly_fields = ['create_date']

class CPUInline(admin.TabularInline):
    model = models.CPU
    exclude = ('memo',)
    readonly_fields = ['create_date']

class NICInline(admin.TabularInline):
    model = models.NIC
    exclude = ('memo',)
    readonly_fields = ['create_date']

class RAMInline(admin.TabularInline):
    model = models.RAM
    exclude = ('memo',)
    readonly_fields = ['create_date']

class DiskInline(admin.TabularInline):
    model = models.Disk
    exclude = ('memo',)
    readonly_fields = ['create_date']

class AssetAdmin(admin.ModelAdmin):
   # list_display = ('id','asset_type','sn','name','manufactory','management_ip','idc','business_unit','admin','trade_date','status')
    #这里就是我刚才关联的server表，cpu表，ram表
    inlines = [ServerInline,CPUInline,RAMInline,DiskInline,NICInline]
    search_fields = ['sn',]
    list_filter = ['idc','manufactory','business_unit','asset_type']
    choice_fields = ('asset_type','status')
    fk_fields = ('manufactory','idc','business_unit','admin')
    list_per_page = 10
    list_filter = ('asset_type','status','manufactory','idc','business_unit','admin','trade_date')
    dynamic_fk = 'asset_type'
    dynamic_list_display = ('model','sub_asset_type','os_type','os_distribution')
    dynamic_choice_fields = ('sub_asset_type',)
    m2m_fields = ('tags',)

class NicAdmin(admin.ModelAdmin):
    list_display = ('name','macaddress','ipaddress','netmask','bonding')
    search_fields = ('macaddress','ipaddress')


class EventLogAdmin(admin.ModelAdmin,BaseAdmin):
    list_display = ('name','colored_event_type','asset','component','detail','date','user')
    search_fields = ('asset',)
    list_filter = ('event_type','component','date','user')


from django.contrib.contenttypes.models import ContentType
from django.http import HttpResponseRedirect




class NewAssetApprovalZoneAdmin(admin.ModelAdmin):
    list_display = ('sn','asset_type','manufactory','model','cpu_model','cpu_count','cpu_core_count','ram_size','os_distribution','os_release','date','approved','approved_by','approved_date')
    actions = ['approve_selected_objects']
    def approve_selected_objects(modeladmin, request, queryset):
        selected = request.POST.getlist(admin.ACTION_CHECKBOX_NAME)
        ct = ContentType.objects.get_for_model(queryset.model)
        return HttpResponseRedirect("/asset/new_assets/approval/?ct=%s&ids=%s" % (ct.pk, ",".join(selected)))
    approve_selected_objects.short_description = "批准入库"

# Now register the new UserAdmin...

# ... and, since we're not using Django's built-in permissions,
# unregister the Group model from admin.
#admin.site.unregister(Group)
admin.site.register(models.UserProfile,UserAdmin)
#在资产总表关联了AssetAdmin里面定制的表
admin.site.register(models.Asset,AssetAdmin)
admin.site.register(models.Server)
admin.site.register(models.NetworkDevice)
admin.site.register(models.IDC)
admin.site.register(models.BusinessUnit)
admin.site.register(models.Contract)
admin.site.register(models.CPU)
admin.site.register(models.Disk)
admin.site.register(models.NIC,NicAdmin)
admin.site.register(models.RAM)
admin.site.register(models.Manufactory)
admin.site.register(models.Tag)
admin.site.register(models.Software)
admin.site.register(models.EventLog,EventLogAdmin)
admin.site.register(models.NewAssetApprovalZone,NewAssetApprovalZoneAdmin)