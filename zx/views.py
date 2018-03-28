# -*- coding: utf-8 -*-

from django.shortcuts import render,HttpResponse,redirect
from django.contrib.auth.decorators import login_required

from django.contrib.auth import authenticate,login

def auth_login(request):
    if request.method == "POST":
        email = request.POST['email']
        password = request.POST['password']
        user=authenticate(username=email,password=password)
        if user:
            #让用户登录,生成session
            login(request,user)
            return redirect('/')
        else:
            return redirect('/login')
    elif request.method == "GET":
        login_strings = {"username":"username","password":"password"}
        return render(request,'root/login.html',login_strings)


#django自带的用户是否登录函数
@login_required
def index(request):
    # return render(request,'index.html')
    return render(request, 'root/index.html')