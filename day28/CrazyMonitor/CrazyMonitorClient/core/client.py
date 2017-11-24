# -*- coding: utf-8 -*-

import time
from conf import settings
import urllib
import urllib2
import json
import  threading
from plugins import plugin_api

'''
    本代码做了以下事项
    1. load_latest_configs,从服务器端加载配置，通过url_request发送get请求拿到配置数据。
    2.forever_run 无限循环启动服务，包括从服务端加载配置和客户端调用监控插件将数据返回给服务端
    3. invoke_plugin 调用监控插件拿到数据然后调用url_request把数据返回给服务端
    4. url_request 里面有get和post请求，get拿到配置信息，post将拿到的数据返回给服务端

'''


class ClientHandler(object):
    def __init__(self):
        #这里首先初始化一个字典，存储最新的配置信息
        self.monitored_services = {}

    def load_latest_configs(self):
        '''
        从monitor服务器加载最新的监视器配置
        :return:
        '''
        #从配置文件里面拿出请求的方式
        request_type = settings.configs['urls']['get_configs'][1]
        #从配置文件里面拿出请求的接口url和主机id
        url = "%s/%s" %(settings.configs['urls']['get_configs'][0],settings.configs["HostId"])
        #通过url_request 函数来从服务器拿到最新的配置文件
        latest_configs = json.loads(self.url_request(request_type,url))
        #然后更新到字典里面
        self.monitored_services.update(latest_configs)

    def forever_run(self):
        '''
        永远启动客户端程序
        :return:
        '''
        #设置一个False的标志
        exit_flag = False
        #设置一个初始时间,作为判断是否应该检查有最新配置用
        config_last_update_time = 0
        while not exit_flag:
            # 当前时间  -   配置最后更新时间   >   配置更新时间间隔
            if time.time() - config_last_update_time > settings.configs['ConfigUpdateInterval']:
                #那么就获取最新配置文件
                self.load_latest_configs()
                #并将从服务器拿到的最新配置文件打印出来
                print("Loaded latest config:", self.monitored_services)
                #然后把当前时间赋值给最后一次配置更新时间
                config_last_update_time = time.time()

                '''
                启动监控服务
                接收服务器返回的数据的字典monitored_services格式类型为
                {"services": {"LinuxCpu": ["n/a", 60], "LinuxMemory": ["n/a", 30], "LinuxNetwork": ["n/a", 60]}}
              '''
            for service_name,val in self.monitored_services['services'].items():
                '''
                代表这是第一次监控,也就是说有没有['n/a',60]的参数,以及等会需要传入一个计数器的初始值进去，如果有，那么就不传了
                这个计数器是判断要监控的数据的插件有没有执行的时间，也就是多少时间监控一次的意思
             '''
                if len(val) == 2:
                    self.monitored_services['services'][service_name].append(0)
                    #监控的间隔时间
                monitor_interval = val[1]
                #监控资源插件调用的最后时间
                last_invoke_time = val[2]
                #  如果当前时间  -  监控插件调用的时间  >  监控间隔时间
                if time.time() - last_invoke_time > monitor_interval:
                    print(last_invoke_time,time.time())
                    #首先把当前时间赋值给 监控资源插件调用的最后时间
                    self.monitored_services['services'][service_name][2] = time.time()
                    '''
                    然后启动一个线程去执行这个监控插件,
                    然后把服务名和['n/a',60,0]的参数传入进去
                 '''
                    t = threading.Thread(target=self.invoke_plugin,args=(service_name,val))
                    t.start()
                    print("Going to monitor [%s]" % service_name)
                else:
                    print("Going to monitor [%s] in [%s] secs" % (service_name,
                                                                                 monitor_interval - (time.time()-last_invoke_time)))
            #每循环一个监控服务器，那么休息一秒在执行下一个监控服务
            time.sleep(1)

    #这个函数里面就是去执行监控的插件，在客户端拿到数据并返回给服务端的。
    def invoke_plugin(self,service_name,val):
        #在字典里面取出监控插件的名称，一定要知道插件的名称，否则不知道监控哪个服务
        plugin_name = val[0]
        #然后通过反射的方式来执行监控插件，现在查看监控插件有哪些。
        if hasattr(plugin_api,plugin_name):
            func = getattr(plugin_api,plugin_name)
            plugin_callback = func()

            #然后将返回的值存入一个字典，返回给服务器端
            report_data = {
                'client_id':settings.configs['HostId'],
                'service_name':service_name,
                'data':json.dumps(plugin_callback),
            }

            #请求动作为post
            request_action = settings.configs['urls']['service_report'][1]
            #请求的url
            request_url = settings.configs['urls']['service_report'][0]
            print('---report data:',report_data)
            #调用url_request请求函数，并把参数传入进去
            self.url_request(request_action,request_url,params=report_data)
        else:
            print("\033[31;1mCannot find service [%s]'s plugin name [%s] in plugin_api\033[0m"% (service_name,plugin_name ))
            print('--plugin:',val)


    #action是请求的方式，url是请求的url,extra_data是留着扩展会不会有其它参数传入进来的（一般是post的请求传来的）
    def url_request(self,action,url,**extra_data):

        #将要请求的完整的url拼接起来
        abs_url = "http://%s:%s/%s" %(settings.configs['Server'],
                                      settings.configs['ServerPort'],
                                      url)

        if action in ('get','GET'):
            print (abs_url,extra_data)
            try:
                #访问服务器的接口，如果得到值就返回，这里可能得到错误的值，所以要异常处理。
                req = urllib2.Request(abs_url)
                req_data = urllib2.urlopen(req,timeout=settings.configs['RequestTimeout'])
                callback = req_data.read()
                return callback
            except urllib2.URLError as e:
                exit("\033[31;1m%s\033[0m"%e)

        #如果action为POST
        elif action in ('post','POST'):
            print (abs_url,extra_data)
            try:
                '''
                这里采用了多行注释，是要注意，extra_data['params']传入进来的参数是这个格式，是
                invoke_plugin函数传入进来的，得到这个值后解码，然后交给urllib2去请求服务端的api，
                这里也不确定传来的数据是否合法，所以这里也加了一个try。
              '''
                data_encode = urllib.urlencode(extra_data['params'])
                req = urllib2.Request(url=abs_url,data=data_encode)
                res_data = urllib2.urlopen(req,timeout=settings.configs['RequestTimeout'])
                callback = res_data.read()
                callback = json.loads(callback)
                print "\033[31;1m[%s]:[%s]\033[0m response:\n%s" %(action,abs_url,callback)
                return callback
            except Exception as e:
                # print('---exec',e)
                exit("\033[31;1m%s\033[0m"%e)


