#!/usr/bin/env python
#--*-- coding:utf-8 --*--


from django import forms
from cmdb import models

class HostForm(forms.Form):
    ip = forms.CharField(widget=forms.TextInput(attrs={'placeholder':u'IP'}))
    port = forms.CharField(widget=forms.TextInput(attrs={'placeholder':u'端口'}))
    hostgroup = forms.CharField(
        widget=forms.Select()
    )


    def __init__(self,*args,**kwargs):
        super(HostForm,self).__init__(*args,**kwargs)
        self.fields['hostgroup'].widget.choices = models.HostGroup.objects.all().values_list('id','groupname')


class HostGroupForm(forms.Form):
    hostgroupname = forms.CharField()

class DelHost(forms.Form):
    delhost = forms.CharField(widget=forms.TextInput(attrs={'placeholder':u'输入主机ID'}))

class UpdateHost(forms.Form):
    updateid = forms.CharField(widget=forms.TextInput(attrs={'placeholder':u'输入更新的ID'}))
    updateip = forms.CharField(widget=forms.TextInput(attrs={'placeholder':u'主机IP'}))
    updateport = forms.CharField(widget=forms.TextInput(attrs={'placeholder':u'主机端口'}))
