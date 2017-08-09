#!/usr/bin/env python
#--*-- coding:utf8 --*--

from django.shortcuts import redirect,HttpResponse,render
from cmdb import models
from cmdb.forms import login_form,index_form

def login(request):
    obj = login_form.createlogin(request.POST)
    if request.method == "POST":
        if obj.is_valid():
            userkey = obj.clean()
            intusername = userkey['username']
            intpassword = userkey['password']
            sqluserkey = models.User.objects.all().values('username','password')
            user_list = {}
            #生成key为用户名的字典
            for i in sqluserkey:
                user = i['username']
                pwd = i['password']
                user_list[user] ={'username':user,'password':pwd}
            if intusername in user_list.keys():
                if intpassword == user_list[intusername]['password']:
                    request.session['IS_LOGIN'] = True
                    request.session['intusername'] = intusername
                    return redirect('/index/')
                else:
                    return render(request,'login.html',{'obj':obj,'status':"用户名密码错误"})
            else:
                return render(request,'login.html',{'obj':obj,'status':"用户不存在"})
        else:
            return render(request,'login.html',{'obj':obj,'status':"输入不合法"})

    return render(request,'login.html',{'obj':obj})

def auth(func):
    def inner(*i,**j):
        IsLogin = i[0].session.get('IS_LOGIN',False)
        if not IsLogin:
            return redirect('/login/')
        temp = func(*i,**j)
        return temp
    return inner

@auth
def index(request):
    user_list = models.Host.objects.all()
    obj = index_form.HostForm()
    obj_group = index_form.HostGroupForm()
    del_host = index_form.DelHost(request.POST)
    update_host = index_form.UpdateHost(request.POST)
    username = request.session.get('intusername')
    if request.method == 'POST':
        user_obj = index_form.HostForm(request.POST)
        group_obj = index_form.HostGroupForm(request.POST)
        if user_obj.is_valid():
            all_data = user_obj.clean()
            #这里因为有外键，使用的是外键的方式
            group_obj = models.HostGroup.objects.get(id=all_data['hostgroup'])
            print group_obj
            models.Host.objects.create(ip=all_data['ip'],
                                       port=all_data['port'],
                                       groupname=group_obj
            )
        #第二张form表单，如果第一个form不生效，就来这里判断
        elif group_obj.is_valid():
            group_data = group_obj.clean()
            models.HostGroup.objects.create(groupname=group_data['hostgroupname'])
        elif del_host.is_valid():
            del_data = del_host.clean()
            # del_obj = models.Host.objects.get(id=del_data['delhost'])
            # print del_obj
            host_id = del_data['delhost']
            models.Host.objects.filter(id=host_id).delete()
        elif update_host.is_valid():
            update_data = update_host.clean()
            update_id = update_data['updateid']
            update_ip = update_data['updateip']
            update_port = update_data['updateport']
            models.Host.objects.filter(id=update_id).update(ip=update_ip,port=update_port)
    return render(request,'index.html',{'username':username,'obj':obj,'obj_group':obj_group,'user_list':user_list,'del_host':del_host,'update_host':update_host},)

def logout(request):
    del request.session['IS_LOGIN']
    return redirect('/login/')