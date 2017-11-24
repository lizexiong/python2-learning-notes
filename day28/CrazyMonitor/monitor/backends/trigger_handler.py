# -*- coding: utf-8 -*-

from monitor.backends import redis_conn
import pickle,time
from monitor import models
from django.core.mail import send_mail
from CrazyMonitor import settings


class TriggerHandler(object):

    def __init__(self,django_settings):
        self.django_settings = django_settings
        self.redis = redis_conn.redis_conn(self.django_settings)
        self.alert_counters ={} #纪录每个action的触发报警次数
        '''alert_counters = {
            1: {2:{'counter':0,'last_alert':None}, #k 1是主机id, {2:{'counter'}} 2是trigger id
                4:{'counter':1,'last_alert':None}},  #k是action id,
            #2: {2:0},
        }'''

    #start listening and watching the needed to be handled triggers from other process
    def start_watching(self):
        #开始订阅
        radio = self.redis.pubsub()
        radio.subscribe(self.django_settings.TRIGGER_CHAN)
        radio.parse_response() #开始watch
        print("\033[43;1m************start listening new triggers**********\033[0m")
        self.trigger_count = 0
        while True:
            #如果没有告警，这里就一直监听，如果有就交给下一条函数处理
            msg = radio.parse_response()
            self.trigger_consume(msg)

    def trigger_consume(self,msg):
        self.trigger_count += 1
        print("\033[41;1m************Got a trigger msg [%s]**********\033[0m" % self.trigger_count)
        trigger_msg = pickle.loads(msg[2])
        print("msg[2]:",pickle.loads(msg[2]))
        # print ('msg:',msg)
        #print(trigger_msg)
        #print(trigger_msg['positive_expressions'][0]['expression_obj'])

        '''
        以下是msg的消息，所以为什么要取下标为2的值
        ('msg:', ['message', 'trigger_event_channel', "(dp0\nS'positive_expressions'\np1
        \n(lp2\n(dp3\nS'calc_res'\np4\nI01\nsS'calc_res_val'\np5\nF98.37\nsS'expression_
        obj'\np6\nI3\nsS'service_item'\np7\nNsasS'start_time'\np8\nF1508256244.667\nsS't
        rigger_id'\np9\nI1\nsS'duration'\np10\nNsS'time'\np11\nS'2017-10-18 00:04:04'\np
        12\nsS'msg'\np13\nVLinuxCpu\np14\nsS'host_id'\np15\nI2\ns."])
        msg[2]:
        ('msg[2]:', {'positive_expressions': [{'calc_res': True, 'calc_res_val': 97.66,
        'expression_obj': 1, 'service_item': None}, {'calc_res': True, 'calc_res_val': 0
        .02, 'expression_obj': 2, 'service_item': None}], 'start_time': 1508330442.825,
        'trigger_id': 1, 'msg': u'mac trigger', 'time': '2017-10-18 20:40:42', 'duration
        ': None, 'host_id': 2})
       '''
        action = ActionHandler(trigger_msg,self.alert_counters)
        action.trigger_process()

#负责把达到报警条件的trigger进行分析 ,并根据 action 表中的配置来进行报警
class ActionHandler(object):

    def __init__(self,trigger_data,alert_counter_dic):
        self.trigger_data = trigger_data
        self.alert_counter_dic = alert_counter_dic

    #分析trigger并报警
    def trigger_process(self):
        print('Action Processing'.center(50,'-'))

        if self.trigger_data.get('trigger_id') == None:
            print (self.trigger_data)
            if self.trigger_data.get('msg'):
                print(self.trigger_data.get('msg'))
                #既然没有trigger id,直接报警给管理 员
            else:
                print("\033[41;1mInvalid trigger data %s\033[0m" % self.trigger_data)

        else:#正经的trigger 报警要触发了
            print("\033[33;1m%s\033[0m" %self.trigger_data)

            trigger_id = self.trigger_data.get('trigger_id')
            host_id = self.trigger_data.get('host_id')
            trigger_obj =models.Trigger.objects.get(id=trigger_id)
            actions_set = trigger_obj.action_set.select_related()#找到这个trigger所关联的action list_
            #告警模块暂时省略，未完成版本
