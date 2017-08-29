# -*- coding: utf-8 -*-

from django.contrib.auth.models import  Group
from rest_framework import viewsets
from asset.serializers import UserSerializer, GroupSerializer , AssetSerializer,ManufactorySerializer
from asset.models import UserProfile,Asset,Manufactory


class UserViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows users to be viewed or edited.
    """
    queryset = UserProfile.objects.all()
    serializer_class = UserSerializer


class GroupViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows groups to be viewed or edited.
    """
    queryset = Group.objects.all()
    serializer_class = GroupSerializer

class AssetViewSet(viewsets.ModelViewSet):
    queryset = Asset.objects.all()
    serializer_class = AssetSerializer

class ManufactoryViewSet(viewsets.ModelViewSet):
    queryset = Manufactory.objects.all()
    serializer_class = ManufactorySerializer








