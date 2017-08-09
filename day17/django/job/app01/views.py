# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.shortcuts import render
from django.shortcuts import HttpResponse

def md5(str):
    import hashlib
    import types
    if type(str) is types.StringType:
        m = hashlib.md5()
        m.update(str)
        return m.hexdigest()
    else:
        return ''

def login(request):
    if request.method == "POST":
        input_email = request.POST['email']
        input_password = request.POST['password']
        from app01 import models
        user_info_list = models.userinfo.objects.all().values_list('email','pwd')
        user_email_list = models.userinfo.objects.all().values('email')
        user_pwd_list = models.userinfo.objects.all().values('pwd')
        user_email = []
        user_pwd = []
        userdict = {}
        for i in user_info_list:
            value_email = i[0]
            value_pwd = i[1]
            userdict[value_email]={'email':value_email,'pwd':value_pwd}
        for i in user_email_list:
            user_email.append(i['email'])
        if input_email in userdict.keys():
            if input_password == userdict[input_email]['pwd']:
                from django.shortcuts import redirect
                return redirect("https://www.baidu.com")
            else:
                return render(request,'login.html',{'status':"用户名和密码错误"})
        else:
            return render(request,'login.html',{'status':'用户不存在'})
    return render(request,'login.html')

def register(request):
    if request.method == 'POST':
        from app01 import models
        user_info_list =  models.userinfo.objects.all().values_list('email','pwd')
        user_email_list = models.userinfo.objects.all().values('email')
        user_email = []
        #print user_email_list[1]['email']
        for i in user_email_list:
            user_email.append(i['email'])
        input_email = request.POST['res_email']
        input_password = request.POST['res_password']
        input_password = md5(str(input_password))
        print str(input_password)
        if len(input_email) > 0 and len(input_password) > 0:
            if input_email in user_email:
                return render(request,'register.html',{'UserPresence':'用户名已存在'})
            else:
                models.userinfo.objects.create(email=input_email,pwd=input_password)
                return render(request,'login.html')
        else:
            return render(request,'register.html',{'UserPresence':'没有信息录入'})
    return render(request,'register.html')

def BatchRegister(request):
    if request.method == 'POST':
        input_batch = request.POST['BatchR'].strip('\r\n')
        input_batch = input_batch.split(',')

        from app01 import models
        user_email_list = models.userinfo.objects.all().values('email')
        user_email = []
        #print user_email_list[1]['email']
        for i in user_email_list:
            user_email.append(i['email'])
        arr_list = []
        arr_dict = {}
        for i in input_batch:
            arr_list.append(i.split(':'))
        for i in arr_list:
            email = i[0]
            pwd = i[1]
            arr_dict[email]={'email':email,'pwd':pwd}
        for i,j in arr_dict.items():
            email = arr_dict[i]['email']
            pwd =  arr_dict[i]['pwd']
            if email in user_email:
                pass
            else:
                if len(email) > 0 and len(pwd) > 0:
                    models.userinfo.objects.create(email=email,pwd=pwd)
                else:
                    pass

    return render(request,'BatchRegister.html')