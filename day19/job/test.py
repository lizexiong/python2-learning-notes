#!/usr/bin/env python
#--*-- coding:utf8 --*--

from django.shortcuts import redirect,HttpResponse,render
from cmdb import models
from cmdb.forms import create_form,login_form

def login(request):
    obj = login_form.createlogin(request.POST)
    if request.method == "POST":
        if obj.is_valid():
            userkey = obj.clean()
            intusername = userkey['username']
            intpassword = userkey['password']
            sqluserkey = models.User.objects.all().values('username','password')
            user_list = {}
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
            return render(request,'login.html',{'obj':obj,'status':"用户名密码错误"})

    return render(request,'login.html',{'obj':obj})



def auth(func):
    def inner(*i,**j):
        IsLogin = j.session.get('IS_LOGIN',False)
        if not IsLogin:
            return redirect('/login/')
        temp = func(*i,**j)
        return temp


@auth
def index(request):
    return HttpResponse('ok')