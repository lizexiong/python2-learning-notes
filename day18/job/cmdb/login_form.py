#!/usr/bin/env python
#--*-- coding:utf-8 --*--


from django import forms

class LoginForm(forms.Form):
    email = forms.CharField(widget=forms.TextInput(attrs={'class':'input_form',
                            'placeholder':u'邮箱'}))
    password = forms.CharField(error_messages={'required':u'不能为空'},
                            widget=forms.PasswordInput(attrs={'class':'input_form',
                            'placeholder':u'密码'}))

