# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.shortcuts import render,HttpResponse

from django import forms



def mobile_validate(value):
    import re
    from django.core.exceptions import ValidationError
    mobile_re = re.compile(r'^(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$')
    if not mobile_re.match(value):
        raise ValidationError('手机号码格式错误')

class UserInfo(forms.Form):

    user_type_choice = (
        (0, u'普通用户'),
        (1, u'高级用户'),
    )

    user_type = forms.IntegerField(widget=forms.widgets.Select(choices=user_type_choice,
                                                                  attrs={'class': "form-control"}))

    email = forms.EmailField(error_messages={'required':u'邮箱不能为空'})  #()里面不设置值，表示默认不能为空
    host = forms.CharField(error_messages={'required':u'主机不能为空'})
    port = forms.CharField(error_messages={'required':u'端口不能为空'})
    mobile = forms.CharField(validators=[mobile_validate,],
                             error_messages={'required':u'手机号不能为空'},
                             widget=forms.TextInput(attrs={'class': "form-control",
                                                          'placeholder': u'手机号码'}))

def user_list(request):
    obj = UserInfo()
    if request.method == 'POST':

        user_input_obj =UserInfo(request.POST)  #把提交的所有的数据提交到user_input_obj里面

        if  user_input_obj.is_valid():       #is_valid判断是否为空
            data = user_input_obj.clean()       #获取封装在里面的数据
            print data,user_input_obj.is_valid()
        else:
            error_msg = user_input_obj.errors.as_data()
            print error_msg,user_input_obj.is_valid()
            return render(request,'user_list.html',{'obj':user_input_obj,'errors':error_msg})
                                                        #这里的值是为了提示我哪里为什么不合法

    return render(request,'user_list.html',{'obj':obj})         #这里的网页渲染为增加标签


def ajax_data(request):
    print request.POST
    return HttpResponse('ok')

def ajax_data_set(request):
    # print request.POST
    import json
    ret = {'status':True,'error':''}
    try:
        print request.POS
    except Exception,e:
        ret['status']=False
        ret['error']=str(e)

    return HttpResponse(json.dumps(ret))
