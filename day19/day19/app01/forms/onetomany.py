#!/usr/bin/env python
#--*-- coding:utf-8 --*--


from django import forms
from app01 import models


class CreateForm(forms.Form):
    username = forms.CharField()
    usergroup_id = forms.IntegerField(
        widget=forms.Select()
    )

    def __init__(self,*args,** kwargs):
        super(CreateForm,self).__init__(*args,**kwargs)
        self.fields['usergroup_id'].widget.choices = models.UserGroupNew.objects.all().values_list('id','caption')