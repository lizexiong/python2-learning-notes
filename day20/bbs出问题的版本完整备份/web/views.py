# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.shortcuts import render,HttpResponse,redirect,HttpResponseRedirect
from web import models
from django.core.exceptions import ObjectDoesNotExist
from django.contrib.auth import authenticate,logout
from django.contrib.auth import login as auth_login
from web.form_article import handle_upload_file
# Create your views here.

def index(request):
    articles =  models.Article.objects.all()
    return render(request,'index.html',{'articles':articles})

def category_americal(request,category_id):
    print category_id
    articles = models.Article.objects.filter(category_id=category_id)
    print articles
    return render(request,'index.html',{'articles':articles})

def article_detail(request,article_id):
    try:
        # get拿不到数据就报错
        article_obj = models.Article.objects.get(id=article_id)
    except ObjectDoesNotExist as e:
        return render(request,'404.html',{'err_msg':u"文章不存在！"})
    return render(request,'article.html',{'article_obj':article_obj})


def new_article(request):
    from web.form_article import Article_form
    if request.method == 'POST':
        print request.POST
        article_form = Article_form(request.POST,request.FILES)
        if article_form.is_valid():
            # print ('corrent',article_form.cleaned_data)
            article_form = article_form.cleaned_data
            article_form['author_id'] = request.user.userprofile.id
            #这里的request.FILES['head_img']就是文件了
            img_path = handle_upload_file(request,request.FILES['head_img'])
            print request.FILES,'---------------------------'
            article_form['head_img'] = img_path
            article_obj = models.Article(**article_form)
            article_obj.save()
            return render(request,'new_article.html',{'article_obj':article_obj})
        else:
            print ('err',article_form.errors)

    category_list = models.Category.objects.all()
    return render(request,'new_article.html',{'category_list':category_list})

def login(request):
    err_msg = ''
    if request.method == 'POST':
        print request.POST
        username = request.POST.get('username')
        password = request.POST.get('password')
        #验证用户名是否相等
        user = authenticate(username=username,password=password)
        if user is not None:
            #生成session
            auth_login(request,user)
            return HttpResponseRedirect('/')
        else:
            err_msg = '用户名或者密码错误'
    return render(request,'login.html',{'err_msg':err_msg})

def acc_logout(request):
    logout(request)
    return HttpResponseRedirect('/')