
# -*- coding: utf-8 -*-
"""bbs URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.11/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import url
from django.contrib import admin
from web import views

urlpatterns = [
    url(r'^$', views.index,name='index'),
    url(r'^admin/', admin.site.urls),
    #这里url别名方式，如果这里写死了，url更改，前端也要更改，使用name别名的方式这里不管怎么改，前端都不需要改。
    url(r'^category/(\d+)/$',views.category_americal,name='category'),
    url(r'^article/(\d+)/$',views.article_detail,name='article_detail'),
    url(r'^article/new/',views.new_article,name='new_article'),
    url(r'^login/',views.login,name='login'),
    url(r'^logout/',views.acc_logout,name='logout'),
]
