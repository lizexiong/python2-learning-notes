# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.shortcuts import render,HttpResponse,redirect

from django.views.decorators.cache import cache_page
from django import forms
from cmdb import login_form
from cmdb import models

def login(request):
    obj = login_form.LoginForm()
    if request.method == "POST":
        user_input_obj = login_form.LoginForm(request.POST)
        if user_input_obj.is_valid():
            data = user_input_obj.clean()
            input_email = data['email']
            input_password = data['password']
            sql_user_list = models.UserList.objects.all().values('email','password')
            print sql_user_list
            user_list = {}
            for i in sql_user_list:
                value_email = i['email']
                value_password = i['password']
                user_list[value_email]={'email':value_email,'password':value_password}
            if input_email in user_list.keys():
                print input_password,'------------'
                print user_list[input_email]
                if input_password == user_list[input_email]['password']:
                    request.session['IS_LOGIN'] = True
                    request.session['input_email'] = input_email
                    return redirect('/index/')
                else:
                    return render(request,'login.html',{'obj':obj,'status':'用户名或密码错误'})
            else:
                return render(request,'login.html',{'obj':obj,'status':'用户名不存在'})
        else:
            error_msg = user_input_obj.errors
            return render(request,'login.html',{'obj':user_input_obj,'errors':error_msg})
    return render(request,'login.html',{'obj':obj})


def index(request):
    if request.method == "POST":
        print request.POST
        host =  request.POST.get('h',False)
        port = request.POST.get('p',False)
        status = request.POST.get('s',False)
        business = request.POST.get('b',False)
        up_host_list = models.HostList.objects.all().values('host','port','status','business')
        for i in up_host_list:
            print i['port']
            print '---'
            print port
            models.HostList.objects.filter(port=i['port']).update(host=host,status=status,business=business)

    is_login = request.session.get('IS_LOGIN',False)
    # print is_login
    if is_login:
        input_email = request.session.get('input_email')
        sql_host_list = models.HostList.objects.all().values('host','port','status','business')
        #print sql_host_list
        dict = {'username':input_email,'sql_host':sql_host_list}
        return render(request,'index.html',dict)

    else:
        return redirect('/login/')


def logout(request):
    del request.session['IS_LOGIN']
    return redirect('/login/')

def add(request):
    host =  request.POST.get('h',False)
    port = request.POST.get('p',False)
    status = request.POST.get('s',False)
    business = request.POST.get('b',False)
    print host,port,status,business
    from cmdb import models
    if request.method == 'POST':
        if len(host) > 0 and len(port) > 0 and len(status) > 0 and len(business) > 0 and host != 'False' and port != 'False' and status != 'False':
            models.HostList.objects.create(host=host,port=port,status=status,business=business)
        else:
            return render(request,'add.html',{'null':'输入信息为空'})
    return render(request,'add.html')