# -*- coding: utf-8 -*-
from __future__ import unicode_literals
from django.views.decorators.csrf import csrf_exempt


from django.shortcuts import render,HttpResponse
from monitor.serializer import ClientHandler,get_host_triggers
import json
from monitor.backends import data_optimization,data_processing
from monitor.backends import redis_conn
from monitor import serializer
from CrazyMonitor import settings
import models


#下面的函数生成一个redis的连接池,把配置文件传进入
REDIS_OBJ = redis_conn.redis_conn(settings)


#提取客户端的最新配置，如果有配置就返回给网页，返回给网页只是给开发人员调试用
def client_configs(request,client_id):
    print("--->",client_id)
    config_obj = ClientHandler(client_id)
    config = config_obj.fetch_configs()
    if config:
        return HttpResponse(json.dumps(config))

#这里使用装饰器的csrf因为上报的消息不方便携带cookie，所以直接不用csrf了
@csrf_exempt
def service_data_report(request):
    if request.method == "POST":
        print("---->",request.POST)
        try:
            print('host=%s, service=%s' %(request.POST.get('client_id'),request.POST.get('service_name') ) )
            data = json.loads(request.POST['data'])
            client_id = request.POST.get('client_id')
            service_name = request.POST.get('service_name')
            #把POST数据存入到redis连接池里面
            data_saveing_obj = data_optimization.DataStore(client_id,service_name,data,REDIS_OBJ)

            #day29开始
            '''
            在这里同时触发监控，当数据存入进如redis的时候我就有数据判断是否达到告警阀值了
            1.首先,依靠什么来判断超过阀值了,阀值信息存储在配置文件里，配置文件是从数据库里面拿出来的，
            在trigger表里面有报警阀值。
            这里没有笔记，所以看一下tirgger表是怎么填写的，以及看一下表结构
          '''

            #把上报的主机的主机根据id把主机对象取出来，通过这个对象查询一些如报警阀值等参数。
            #主机对象 → 主机属于哪些模版 → 模版对应哪些trigger → 然后循环取出trigger → 然后查看自己服务在不在trigger里
            host_obj = models.Host.objects.get(id=client_id)
            #取出主机对象后，在函数里找到这个这个主机的触发器
            service_triggers = get_host_triggers(host_obj)

            #先声明一个类实例，这个类里面有可以处理触发器的方法
            triggers_handler = data_processing.DataHandler(settings,connect_redis=False)
            #然后循环这个service_trigger列表,将触发器交给triggers_handler的方法处理计算是否报警(这里只有一个测试的Triggers)
            for trigger in service_triggers:
                #要知道是哪台主机,哪些触发器,以及要处理的redis数据
                triggers_handler.load_service_data_and_calulating(host_obj,trigger,REDIS_OBJ)
            print ("service trigger:",service_triggers)


        except IndexError as e:
            print ("-->err:",e)

    return HttpResponse(json.dumps("---report success---"))