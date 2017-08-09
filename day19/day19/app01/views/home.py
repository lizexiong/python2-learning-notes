#!/usr/bin/env python
#--*-- coding:utf-8 --*--

from django.shortcuts import render,render_to_response,HttpResponse,redirect
from app01.forms import home as HomeForm
from app01 import models

def index(request):

    before = models.UserInfo.objects.all()
    models.UserInfo.objects.create(name='zexoing')
    after = models.UserInfo.objects.all()
    print before
    print after
    print after[0].ctime
    print after[0].uptime
    obj = HomeForm.ImportForm()
    return render(request,'home/index.html',{'obj':obj})


def upload(request):

    if request.method == 'POST':
        Inp_Post = request.POST
        Inp_File = request.FILES
        print Inp_File
        #取post请求是request.POST,那么取文件有单独方法request.FILES
        File_Obj = Inp_File.get('file_name')
        #Inp_File输出信息File_name就是html的name=file_name
        print File_Obj,type(File_Obj)
        print File_Obj.name
        #上传文件的原始名
        f = open(File_Obj.name,'wb')
        for i in File_Obj.chunks():
            f.write(i)
        f.close()
        from django.core.files.uploadedfile import InMemoryUploadedFile
    return render(request,'home/upload.html')

def simplemodel(request):
    # dic =    {'username':'xinzhe','password':'huawei'}
    # models.SimpleModel.objects.create(**dic)
    ret = models.SimpleModel.objects.all()
    print ret,type(ret)
    ret = models.SimpleModel.objects.all().values('username')
    print ret,type(ret)
    ret = models.SimpleModel.objects.all().values_list('id','username')
    print ret,type(ret)
    return HttpResponse('ok')
