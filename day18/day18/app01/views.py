# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.shortcuts import render,HttpResponse,redirect

# Create your views here.

from django.views.decorators.cache import cache_page


def login(request):
    if request.method == 'POST':
        email = request.POST['email']
        pwd = request.POST['pwd']
        if email == 'zexiong' and pwd =='huawei':
            request.session['IS_LOGIN'] = True
            request.session['email'] = 'zexiong'
            return redirect('/app01/index')
        elif email == 'xinzhe' and pwd =='huawei':
            request.session['IS_LOGIN'] = True
            request.session['email'] = 'xinzhe'
            return redirect('/app01/index')
    return render(request,'login.html')

def logout(request):
    del request.session['IS_LOGIN']
    print request.session.items()
    return redirect('/login/')

def index(request):
    #raise Exception('Exception error')
    is_login = request.session.get('IS_LOGIN',False)
    if is_login:
        print 'index',is_login
        print request.session.items()
        email = request.session.get('email',False)
        return render(request,'index.html',{'username':email})
    else:
        return redirect("/login/")

@cache_page(60 * 15)        #请求来了，15分钟内在缓存里面拿值，就不执行这个函数了
def cache_page(request):
    import time
    curr_time = time.time()
    return HttpResponse(curr_time)


def user_list(request,v2,v1):
    return HttpResponse(v2+"----"+v1)