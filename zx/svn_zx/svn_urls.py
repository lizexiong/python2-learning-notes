# -*- coding: utf-8 -*-



from django.conf.urls import url, include
from django.contrib import admin

from svn_zx import views

urlpatterns = [
    url(r'index/$', views.index),
    url(r'^$', views.index),
]