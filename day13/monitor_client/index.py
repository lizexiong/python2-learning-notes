#!/usr/bin/evn python
#--*-- coding:utf-8 --*--

import time,threading
from plugins import plugins_api
from backend.SqlHelper import *
import json

def get_info(rediscli,data,values):
    if hasattr(plugins_api,values['plugin_name']):
        func = getattr(plugins_api,values['plugin_name'])
        #第一课代码注释
        # result = func()
        # rediscli.publish(json.dumps(result))
    #现在要去配置文件拿到设置的阀值，然后和客户端采集到的做对比

        client_info = func()
        #client_info = {'load1': ' 0.02', 'load15': ' 0.00', 'uptime': [' 10:31:15 up  8:17'], 'load5': ' 0.01'}
        #client_info.get(load1)=0.02

        #这里的values在run方法的for已经定义,这里的k,v就是去字典threadingvalues的值
        #k= threading{"load1":}
        #v = threading{"key":"{"operator":"gt", "formula":None,"val":"1.1"}"}
        for k, v in values['threading'].items():
            cli_val = client_info.get(k, None) #这里获取客户端动态采集的load的数值，注意dict.get的使用和config的格式就明白了
                                                 #所以能在这个循环里面拿到client动态获取的值
            print 'cli_vla',"*" * 50,cli_val
            if not cli_val:
                pass
            else:
                import operator
                for ele in v:
                #v这里就是阀值列表={"operator":"gt", "formula":None,"val":"1.1"},ele就是每一个阀值，如“gt”,"1.1"等
                #ele就是把列表里面的项拿出来，拿出来就是字典了。
                #通过operator拿到对比的动作，如gt等

                    if ele['formula']:
                        import __builtin__
                        cli_val = getattr(__builtin__,ele['formula'])(cli_val) #由于这里没有列表，个人感觉用不上，补充知识
                        print 'cli_vla',"*" * 50,cli_val

                    op = getattr(operator, ele['operator'])  #拿到比较gt还是lt
                    #然后执行这个函数，把采集的值和配置里面的值做比较，就可以了
                    cli_val = ((cli_val)).strip()
                    ele['operator'] = ((ele['operator'])).strip()
                    ret = op(cli_val,ele['val'])
                    # print ele['operator'],"bijiao reslut"           #这里加了很多注释，因为str带空格之后就比较就会出问题
                    # print ret,"ret..result"                           #当初在这里花费了很多时间
                    # print cli_val,type(cli_val)
                    # print ele['val'],type(ele['val'])
                    # print "*" * 100
                    if ret:
                        #是否进行复杂的阀值操作,查看有没有complex这个key
                        if not ele.get('complex',None):
                            print "alert"
                        else:
                            #这里v等于key，键   v[key][jianzhi]，这里字典套了字典取到值，
                            currenttime, interval, reltime = time.time(), v['complex']['interval'],v['complex']['relative_time']
                            #如果当前时间 小于 第一次出错时间+间隔时间,如35 < 30+30,如果当前时间为70 > 30+30,那么就要重置了
                            if currenttime< reltime + interval:
                                v["complex"]['has_times'] +=1
                            else:
                                v["complex"]["has_times"] = 0
                                v["complex"]['relative_time']=currenttime
                            #如果记录告警次数大于设定搞进个次数，那么就告警，并重置记录告警次数，将当前时间赋值给最后告警时间。
                            if v["complex"]["has_times"] >= v["complex"]['times']:
                                print 'alert'
                                v['complex']['has_time'] = 0
                                v['complex']['relative_time'] =currenttime



def run(rediscli,config):
    while True:
        for key,values in config.items():
            data = {'hostname':'222'}
            currenttime, interval, pretime = time.time(),values['interval'],values['last_time']
            if currenttime - pretime < interval:
                print "Please Wait..."
            else:
                t = threading.Thread(target=get_info,args=(rediscli,data,values))
                t.start()
                values['last_time']= currenttime
                print pretime
        #这里睡眠一秒就是为了看到for里面的值，不然，就算是else速度太快也看不到
        time.sleep(1)
if __name__ == "__main__":
    """
    #每个指标有自己的检测间隔时间
    config = {
        "load:":{"interval" : 6, "last_time" : 0, "plugin_name": "get_load_info"},
        # "cpu":{"interval": 5, "last_time": 0, "plugin_name": "get_cpu_info"}
    }
    """
    #对比上面的配置文件，什么都没变，只是加了一个threading的字典列表字典
    config = {
            "load" : {
                "last_time":0,
                "interval":10,
                "plugin_name":"get_load_info",
                "threading":{
                    "load1":[
                        {"operator":"gt", "formula":None,"val":"0.1"},
                        #{"operator":"lt", "fornula":None,"val":"5"}
                    ],
                    "load5":[
                        {"operator":"gt", "formula":None,"val":"0.1","complex":{"interval": 30, "times": 5,"has_times": 0, "relative_time": 0}},
                    ]
                }
            },
    }
    redis_cli = RedisHelper()
    run(redis_cli,config)