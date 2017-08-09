#--*-- coding:utf-8 --*--

from django import forms
import os

class Article_form(forms.Form):
    title = forms.CharField(max_length=255,min_length=5)
    category_id = forms.IntegerField()
    summary = forms.CharField(max_length=255,min_length=5)
    head_img = forms.ImageField()
    content =forms.CharField(min_length=10)

def handle_upload_file(request,f):
    #为什么是statics下的，因为他会直接去找settings配置文件下的statics。
    base_img_upload_path = 'static/img'
    #这里注意%s/%s这里有一个  /
    user_path = "%s/%s" %(base_img_upload_path,request.user.userprofile.id)
    print user_path
    if not os.path.exists(user_path):
        os.mkdir(user_path)
    #这里的f是等会views函数传入进来的句柄，f.name可以获取文件名
    with open("%s/%s" %(user_path,f.name),'wb+') as destination:
        #f.chunks是相当于yield，将文件一点一点写入到本地
        for chunk in f.chunks():
            destination.write(chunk)
    return '/static/img/%s/%s' %(request.user.userprofile.id,f.name)
