# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.shortcuts import render
from django.shortcuts import HttpResponse
# Create your views here.

def home(request):
    # return HttpResponse('ok')
    dic = {'name':'zexiong','age':24,'user_list':['zexiong','wuxinzhe']}
    return render(request,'home.html',dic,)

def son(request):
    return render(request,'son.html')

def login(request):
    #如果是POST，那么就检验用户输入
    print request.method
    if request.method == "POST":
        input_email = request.POST['email']
        input_pwd = request.POST['pwd']
        if input_email == "zexiong@huawei.com" and input_pwd == "huawei":
            from django.shortcuts import redirect
            return redirect("http://www.baidu.com")
            # return redirect("/son/")
        else:
            return render(request,'login.html',{'status':"用户名或密码错误"})
    return render(request,'login.html')

def index(request):
    from app01 import models
    if request.method == 'POST':
        input_email = request.POST['user_email']
        input_pwd = request.POST['user_pwd']
        input_text = request.POST['user_text']
        models.userinfo.objects.filter(email=input_email).delete()
        #models.userinfo.objects.filter(email=input_email).update(pwd='huawei')
        #models.userinfo.objects.create(email=input_email,pwd=input_pwd,memo=input_text)
    user_info_list = models.userinfo.objects.all()
    print user_info_list
    return render(request,'index.html',{'user_info_list':user_info_list})