# -*- coding: utf-8 -*-


from django.shortcuts import render
from django import forms
from ipop_zx import models

from django.forms import widgets

class HostUpdateModelForm(forms.ModelForm):

    class Meta:
        model = models.UsedIP #与UsedIP表绑定
        fields = "__all__"  #显示所有字段
        #排除要显示的字段
        exclude = ['network','url3','url4','url5','createtime','sql_createtime','createtime_timestamp','mongo_username','mongo_password']
        #前端通过obj.lables.name 获得主机名字段
        labels = {
                    "id":"id",
                    "name": "主机标识名",
                    "ip": "ip",
                    'mask': "mask",
                    "mac": "mac",
                    "os_type":"操作系统类型",
                    "inteerface":"接口",
                    "hostname": "hostname",
                    "username": "服务器帐号",
                    "password": "服务器密码",
                    "mysql_username": "数据库帐号",
                    "mysql_password": "数据库密码",
                    "other_username": "other帐号",
                    "other_password": "other密码",
                    "network": "网段",
                    "open_port": "开放端口",
                    "url": "url",
                    "url2": "url2",
                    "urls3": "url3",
                    "group": "组",
                    "status": "状态",
                    "content": "备注"
                }
        #给前端html增加属性
        widgets = {
            'id': widgets.Textarea(attrs={'class': 'input-text', }),
            'name': widgets.Textarea(attrs={'class': 'input-text', }),
            'ip': widgets.Textarea(attrs={'class': 'input-text', }),
            'mac': widgets.Textarea(attrs={'class': 'input-text', }),
            'os_type': widgets.Textarea(attrs={'class': 'input-text', }),
            'hostname': widgets.Textarea(attrs={'class': 'input-text', }),
            'createtime': widgets.Textarea(attrs={'class': 'input-text', }),
            'interface': widgets.Textarea(attrs={'class': 'input-text', }),
            'network': widgets.Textarea(attrs={'class': 'input-text', }),
            'open_port': widgets.Textarea(attrs={'class': 'input-text', }),
            'url': widgets.Textarea(attrs={'class': 'input-text', }),
            'url2': widgets.Textarea(attrs={'class': 'input-text', }),
            'status': widgets.Textarea(attrs={'class': 'input-text', }),
            'group': widgets.Textarea(attrs={'class': 'input-text', }),
            'mask': widgets.Textarea(attrs={'class': 'input-text', }),
            'username': widgets.Textarea(attrs={'class': 'input-text', }),
            'password': widgets.Textarea(attrs={'class': 'input-text', }),
            'mysql_username': widgets.Textarea(attrs={'class': 'input-text', }),
            'mysql_password': widgets.Textarea(attrs={'class': 'input-text', }),
            'other_username': widgets.Textarea(attrs={'class': 'input-text', }),
            'other_password': widgets.Textarea(attrs={'class': 'input-text', }),
            'content': widgets.Textarea(attrs={'class': 'textarea','cols':"40",'rows':"10"}),
        }

    #重写方法也可以改变控件属性,但是和exclude模块冲突,如果设置了exclude模块,那么自定义不生效
    # def __init__(self,*args,**kwargs):
    #     super(HostUpdateModelForm, self).__init__(*args,**kwargs)
    #     for field_name in self.base_fields:
    #         field = self.base_fields[field_name]
    #         field.widget.attrs.update({'class':'input-text'})