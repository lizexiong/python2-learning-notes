"""day19 URL Configuration

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
import sys
from django.conf.urls import url
from django.contrib import admin
from app01.views import account
from app01.views import home
from app01.views import onetomany

urlpatterns = [
    url(r'^login/', account.login),
    url(r'^create_user_group/',onetomany.create_user_group),
    url(r'^create_user/',onetomany.create_user ),
    # url(r'^onetomany/',onetomany.index ),
    url(r'^index/', home.index),
    url(r'^upload/', home.upload),
    url(r'^simplemodel/', home.simplemodel),
    url(r'^admin/', admin.site.urls),
]
