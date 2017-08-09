#!/usr/bin/env python
#--*-- coding:utf-8 --*--


from django import forms
from cmdb import models

class createlogin(forms.Form):
    username = forms.CharField(
        widget=forms.TextInput(attrs={'placeholder':u'用户名'})
    )
    password = forms.CharField(
        widget=forms.PasswordInput(attrs={'placeholder':u'密码'})
    )

