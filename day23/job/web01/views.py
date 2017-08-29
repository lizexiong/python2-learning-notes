# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.shortcuts import render,HttpResponse
from web01 import models
import json
from django.db.models import Q

# Create your views here.

def search_host(form_data):
    data = {'ip':[]}
    user_host_list = form_data.get('host_list')
    try:
        new_list = user_host_list.split(',')
    except Exception,e:
        new_list = []
    for i in new_list:
        data['ip'].append(i)
    to_status = form_data.get('host_status')
    data['host_status_id']=to_status
    to_group = form_data.get('host_group')
    data['host_group_id'] = to_group
    to_admin = form_data.get('host_admin')
    data['host_admin_id']=to_admin
    con = Q()
    q1 = Q()
    q1.connector = 'OR'
    for i in data['ip']:
        q1.children.append(('ip',i))
    q2 = Q()
    q1.connector = 'OR'
    for i in data['host_status_id']:
        q2.children.append(('host_status_id',i))
    q3 = Q()
    q1.connector = 'OR'
    for i in data['host_admin_id']:
        q3.children.append(('host_admin_id',i))
    q4= Q()
    q1.connector = 'OR'
    for i in data['host_group_id']:
        q4.children.append(('host_group_id',i))

    con.add(q1,'AND')
    con.add(q2,'AND')
    con.add(q3,'AND')
    con.add(q4,'AND')

    host_result = models.Host.objects.filter(con)
    return host_result

def host_search(request):
    host_admin = models.HostAdmin.objects.all()
    host_group = models.HostGroup.objects.all()
    return render(request,'index.html',{'host_admin':host_admin,'host_group':host_group})


#处理ajax发来的数据然后在返回给前端都在这个函数里面
def to_background(request):
    if request.method == "POST":
        form_data = request.POST
        #得到的结果可能是几个主机，所以这里把结果转换列表
        host_result_obj = list(search_host(form_data))
        data_obj = []
        for i in host_result_obj:
            host_list_obj = list((models.Host.objects.filter(ip=i).values(
               'ip','host_admin__host_admin','host_status__host_status','host_group__host_group')))
            data_obj.append(host_list_obj)
        print data_obj
    #把数据返回到前端
    return HttpResponse(json.dumps(data_obj))
