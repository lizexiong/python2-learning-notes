# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.shortcuts import render,HttpResponse
from web.models import UserProfile
import json
import Queue
import time


# Create your views here.

GLOBAL_MQ = {}

def dashboard(request):
    return render(request,'web_chat/dashboard.html')

def contacts(request):
    contact_dic = {}
    contacts = request.user.userprofile.friends.select_related().values('id','name')
    #得到的contacts是一个列表包含者字典，虽然是列表，还是要转换成列表，否则报错
    contact_dic['contact_list'] = list(contacts)
    #注意qqgroup_set的方法，以前都是我这张表关联其它的表可以额使用select_related,
    #这回是userprofile没有关联qqgroup，只有qqgroup的字段关联了我，所以使用_set.
    groups = request.user.userprofile.qqgroup_set.select_related().values('id','name','max_member_nums')
    contact_dic['groups']=list(groups)
    # print contacts,'--------'
    # print groups,'=========='
    #需要转换成json给前端
    return HttpResponse(json.dumps(contact_dic))

i = 0
def new_msg(request):
    global i
    if request.method == 'POST':
        print (request.POST.get('data'))
        data = json.loads(request.POST.get('data'))
        send_to = data['to']
        print send_to,'send_to，存入字典之前是int，存入后是str'
        if send_to not in GLOBAL_MQ:
            GLOBAL_MQ[send_to] = Queue.Queue()
        data['timestamp'] = time.time()
        #生成队列之后把人的标识通过队列的方式put进入data里面。
        GLOBAL_MQ[send_to].put(data)
        #给前端返回一下这个字典队列里有几条消息
        return HttpResponse(GLOBAL_MQ[send_to].qsize())
    else:
        #这里为什么要转换成字符串，因为GLOBAL_MQ存储的用户id虽然是数字，但是确实str类型，
        #所以用GLOBAL_MQ[send_to]再次取值的时候是取不到的，因为存入进入前是int，存进去是
        #str,所以,我这里要对比的user.idID也要换成字符串。
        request_user = str(request.user.userprofile.id)
        msg_list = []
        #这里打印类型就是为了对比，虽然都是用户id，但是一个类型是int，一个是str
        # print GLOBAL_MQ,request.user,'--------'
        #如果用户id在字典里面，就开始判断，上面的str（）转换就是在这里用处最大，否则无法判断
        if request_user in GLOBAL_MQ:
            num = GLOBAL_MQ[request_user].qsize()
            if num == 0:
                # get拿不到信息就报错，所以这里一定要自定义报错信息
                try:
                    print "Blocking the 60 seconds"
                    #如果没有信息，就阻塞3秒，然后超时
                    msg_list.append(GLOBAL_MQ[request_user].get(timeout=60))
                except Exception as e:
                    print e
                    print "timeout 60"
            #根据消息的条数从队列里面取消息
            print '-------------------------=============================',num
            # for i in range(num):
            #     print i
            #     msg_list.append(GLOBAL_MQ[request_user].get())

            i+=1
            print i
        else:
            # 这里生成一个quque，因为刚打开页面的时候是没有在别人的聊天框内，是没有quque的，那么会一直返回空列表，
            # 那么就把自己的id传入进去进行if 判断，然后就阻塞了
            GLOBAL_MQ[str(request.user.userprofile.id)] = Queue.Queue()
        return HttpResponse(json.dumps(msg_list))













