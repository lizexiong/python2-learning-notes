# -*- coding: utf-8 -*-

from django.contrib.auth.models import  Group
from rest_framework import serializers
#因为我们自定义了user表，所以我们要用自己的UserProfile表
from asset.models import UserProfile
from asset.models import Asset,Manufactory


class UserSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        #这里关联自己定义的表
        model = UserProfile
        #这里表现在web界面要显示哪些字段
        fields = ('url', 'name', 'email', )

class GroupSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Group
        fields = ('url', 'name')

class AssetSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Asset
        #fields展示哪些字段，如果展示的字段表没有列出来就会报错
        fields = ('url','name','manufactory','management_ip','status')
        depth = 3

class ManufactorySerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Manufactory
        fields = ('url','manufactory','support_num','memo')









