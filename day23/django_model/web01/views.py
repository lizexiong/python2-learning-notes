# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.shortcuts import render,HttpResponse
from web01 import models

# Create your views here.

def user_type(request):

    models.UserType.objects.create(caption='USER')
    return HttpResponse('ok')

def user_list(request):
    # user_dic = {
    #     'username':'lizexiong',
    #     'age':26,
    #     'user_type_id': 1,
    # }
    # models.UserList.objects.create(**user_dic)
    # result = models.UserList.objects.all()
    # for i in result:
    #     #这里注意如果要查询出User_type类型的字段，而不是id
    #     print i.username,i.age,i.user_type.caption

    #在Userlist表查找CEO组里所有用户
    # result = models.UserList.objects.filter(user_type__caption = 'CEO')
    # for i in result:
    #     print i.username,i.age,i.user_type.caption

    #获取某个人是什么类型，当前类型下面有多少人
    user_type_obj = models.UserType.objects.filter(caption='CEO')
    for i in user_type_obj:
        print i.userlist_set.select_related().values('username','age','user_type')

    # print user_type_obj.userlist_set.all().count()
    return HttpResponse('ok')

def user_info(request):
    # result = models.Article.objects.all()
    # for i in result:
    #     print i.title
    #     print i.content
    #     print i.favour_set.all().count()
    #     print '===================='

    #哪些文章被一个人赞过
    # result = models.Article.objects.filter(favour__user_obj__username = '李泽雄')
    # for i in result:
    #     print i.title,'--->'
    #     #并查出这篇文章被那些人点过赞
    #     print i.favour_set.select_related().values('user_obj__username')

    #一篇文章有哪些人点过赞
    # result = models.UserInfo.objects.filter(favour__article_obj__title ='风起燕南下')
    # for i in result:
    #     print i.username
    return HttpResponse('ok')

def host_admin(request):
    # host_list = models.Host.objects.filter(id__lt=3)
    # host_admin_obj = models.HostAdmin.objects.get(username='李泽雄')
    # #把id小于三的全部给lizeixong用户管理
    # host_admin_obj.host.add(*host_list)

    #反向添加，将主机id等于3的给用户id大于1的用户管理
    # host_list = models.Host.objects.get(id=3)
    # host_admin_obj = models.HostAdmin.objects.filter(id__gt=1)
    # host_list.hostadmin_set.add(*host_admin_obj)

    #第一种创建方式，传对象进去
    # models.HostRelation.objects.create(
    #     c1=models.Host1.objects.get(id='1'),
    #     c2=models.HostAdmin1.objects.get(username='lizexiong')
    # )

    #第二种方式，直接传入值
    # models.HostRelation.objects.create(
    #     c1_id = 2,
    #     c2_id = 2,
    # )

    relation_list = models.HostRelation.objects.all()
    for i in relation_list:
        print i.c1.ip,i.c2.username

    relation_list1 = models.HostRelation.objects.filter(c1='1')
    for i in relation_list1:
        print '查询lizexiong管理那几台主机'
        print i.c1.ip,i.c2.username

    return HttpResponse('ok')

























