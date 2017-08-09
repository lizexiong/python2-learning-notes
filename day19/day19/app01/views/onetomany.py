#!/usr/bin/env python
#--*-- coding:utf-8 --*--

from django.shortcuts import render,render_to_response,HttpResponse,redirect
from app01 import models
from app01.forms import onetomany as OnetomanyForm

def create_user_group(request):
    models.UserGroupNew.objects.create(caption='CEO')
    models.UserGroupNew.objects.create(caption='ADMIN')
    models.UserGroupNew.objects.create(caption='USER')
    return HttpResponse('ok')

def create_user(request):
    obj = OnetomanyForm.CreateForm(request.POST)
    if request.method == "POST":
        if obj.is_valid():
            all_data = obj.clean()
            #第一种方式，通过对象的方式
            #通过组id获取组的对象，这个外键是一个对象
            # group_obj = models.UserGroupNew.objects.get(id=all_data['usergroup'])
            # print group_obj
            # models.UserNew.objects.create(username=all_data['username'],
            #                               usergroup=group_obj
            #                               )

            #第二种方式，通过数据库方式直接添加
            # models.UserNew.objects.create(username=all_data['username'],
            #                               usergroup_id=all_data['usergroup']
            #                               )

            #第三种方式，通过**kwargs，但是要更改form的插入字段
            models.UserNew.objects.create(**all_data)
        else:
            pass
    # val = request.GET.get('username')
    # user_list = models.UserNew.objects.filter(username=val)

    # val = request.GET.get('usergroup')
    #user_list = models.UserNew.objects.filter(usergroup=val)  #输入组id的方式
    # user_list = models.UserNew.objects.filter(usergroup__caption=val)

    val = request.GET.get('vip')
    user_list = models.UserNew.objects.filter(usergroup__vip__vip=val)
    return render(request,'onetomany/index.html',{'obj':obj,'user_list':user_list})



