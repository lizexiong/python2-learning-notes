#!/usr/bin/env python
#--*-- coding:utf-8 --*--

from django import forms
from app01 import models
class ImportForm(forms.Form):
    # HOST_TYPE_LIST =(
    #     (1,'物理机'),
    #     (2,'虚拟机'),
    # )

    HOST_TYPE_LIST = models.SimpleModel.objects.all().values_list('id','username')

    host_type = forms.IntegerField(
        widget=forms.Select(choices=HOST_TYPE_LIST)
    )


    hostname = forms.CharField()
    admin = forms.IntegerField(
        widget=forms.Select()
    )

    def __init__(self,*args,**kwargs):
        super(ImportForm,self).__init__(*args,**kwargs)
        import json
        f = open('D:\Python\code\day19\day19\db_admin')
        data = f.read()
        data_tuple = json.loads(data)
        self.fields['admin'].widget.choices = data_tuple