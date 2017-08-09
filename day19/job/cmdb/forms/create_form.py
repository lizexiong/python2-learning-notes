#!/usr/bin/env python
#--*-- coding:utf-8 --*--


from django import forms
from cmdb import models

class CreateForm(forms.Form):
    host = forms.CharField()
    hostid = forms.CharField(
        widget=forms.Select()
    )

