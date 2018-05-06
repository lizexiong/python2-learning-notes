# -*- coding: utf-8 -*-




from django.conf.urls import url, include
from django.contrib import admin

from ipop_zx import views

urlpatterns = [
    url(r'index/$', views.index),
    url(r'welcome/$', views.welcome),
    url(r'host_list/$', views.host_list),
    url(r'host_add/$', views.host_add),
    url(r'host_update/$', views.host_update),
    url(r'host_del/$', views.host_del),
    url(r'hosthistory_del/$', views.hosthistory_del),
    url(r'host_details/$', views.host_details),
    url(r'hosthistory_details/$', views.hosthistory_details),

    url(r'host_history/$', views.host_history),
    url(r'group/$', views.group),


    url(r'network/$', views.network),
    url(r'group_list/$', views.group_list),

    url(r'ip_calculate/$', views.ip_calculate,name='fuck'),
    url(r'group_network_list/$', views.group_network_list),

    url(r'excel_to_lead/$', views.excel_to_lead),
    url(r'^$', views.index),
]