# -*- coding: utf-8 -*-




from django.conf.urls import url, include
from django.contrib import admin

from ipop_zx import views

urlpatterns = [
    url(r'index/$', views.index),
    url(r'test/$',views.test),
    url(r'^$', views.index),
]