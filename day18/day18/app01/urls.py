from django.conf.urls import url,include
from django.contrib import admin
from app01 import views

urlpatterns = [
    url(r'^index/$', views.index),
    url(r'^logout/$', views.logout),
    url(r'^cache_page/$', views.cache_page),
]