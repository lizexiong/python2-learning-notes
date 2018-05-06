# -*- coding: utf-8 -*-

from django.shortcuts import render
from django import forms

class HostInfo(forms.Form,):
    '''
        required：是否可以为空。required=True 不可以为空，required=False 可以为空
        max_length=4 最多4个值，超过不会显示
        min_length=2 至少两个值，少于两个会返回提示信息
        error_messages={'required': '邮箱不能为空', 'invalid': '邮箱格式错误'}  自定义错误信息，invalid 是格式错误
        widget=forms.TextInput(attrs={'class': 'c1'}) 给自动生成的input标签自定义class属性
        widget=forms.Textarea()  生成Textarea标签。widget默认生成input标签


    '''



    name = forms.CharField(
        widget=forms.TextInput(attrs={'class': 'input-text'}),
        error_messages={'required': '主机标识名不能为空'}, label='主机标识名')
    ip = forms.GenericIPAddressField(
        widget=forms.TextInput(attrs={'class': 'input-text',}),
        error_messages={'required': 'IP不能为空'},label='ip' )
    mask = forms.CharField(
        widget=forms.TextInput(attrs={'class': 'input-text',
                                      'placeholder':u'255.255.255.0',
                                        'value':'255.255.255.0',}),
                                        error_messages={'required': '子网不能为空'},label='mask')
    mac = forms.CharField(
        widget=forms.TextInput(attrs={'class': 'input-text'}),required=False,label='mac')
    username = forms.CharField(
        widget=forms.TextInput(attrs={'class': 'input-text'}),required=False,label='服务器帐号')
    password = forms.CharField(
        widget=forms.TextInput(attrs={'class': 'input-text'}),required=False,label='服务器密码')
    mysql_username = forms.CharField(
        widget=forms.TextInput(attrs={'class': 'input-text'}),required=False,label='数据库帐号')
    mysql_password = forms.CharField(
        widget=forms.TextInput(attrs={'class': 'input-text'}),required=False,label='数据库密码')
    other_username = forms.CharField(
        widget=forms.TextInput(attrs={'class': 'input-text'}),required=False,label='other帐号')
    other_password = forms.CharField(
        widget=forms.TextInput(attrs={'class': 'input-text'}),required=False,label='other密码')
    os_type = forms.CharField(
        widget=forms.TextInput(attrs={'class': 'input-text'}),required=False,label='操作系统类型')
    hostname = forms.CharField(
        widget=forms.TextInput(attrs={'class': 'input-text'}),required=False,label='hostname')
    interface = forms.CharField(
        widget=forms.TextInput(attrs={'class': 'input-text'}),required=False,label='接口')
    # network = forms.CharField(
    #     widget=forms.TextInput(attrs={'class': 'input-text'}),required=False,label='网段')
    open_port = forms.CharField(
        widget=forms.TextInput(attrs={'class': 'input-text'}),required=False,label='开放端口')
    url = forms.CharField(
        widget=forms.TextInput(attrs={'class': 'input-text'}),required=False,label='url')
    url2 = forms.CharField(
        widget=forms.TextInput(attrs={'class': 'input-text'}),required=False,label='url2')
    status = forms.CharField(
        widget=forms.TextInput(attrs={'class': 'input-text','placeholder':u'使用中','value':'使用中'},),required=False,label='状态')
    group = forms.CharField(widget=forms.TextInput(attrs={'class': 'input-text'}),
                            error_messages={'required':u'主机所在位置不能为空'},label='组')
    content = forms.CharField(
        widget=forms.Textarea(attrs={'class': 'input-text','class':'textarea'}),required=False,label='备注')
