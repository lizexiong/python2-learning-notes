#!/usr/bin/env python
#--*-- coding:utf-8 --*--

from django.shortcuts import render,render_to_response,HttpResponse
from app01.forms import account as AccountForm
import json

def login(request):
    obj = AccountForm.LoginForm(request.POST)
    if request.method == 'POST':
        if obj.is_valid():
            all_data = obj.clean()
        else:
            #Form表单提交
            # error = obj.errors
            # print error
            # print error['username'],type(error['username'])
            # print error['username'][0],type(error['username'][0])

            #ajax
            error = obj.errors.as_json()
            print error,type(error)
            return HttpResponse(error)
            return render(request,'account/login.html',{'obj':obj,'error':error})
    return render(request,'account/login.html',{'obj':obj})