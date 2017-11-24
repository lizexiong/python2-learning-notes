# -*- coding: utf-8 -*-



import time
from monitor.backends import redis_conn
import json,pickle,operator
from monitor import models



class DataHandler(object):
    def __init__(self,django_settings,connect_redis=True):
        self.django_settings = django_settings
        self.poll_interval = 3 #每3秒进行一次检测
        self.config_update_interval = 120 #每120秒重新从数据库加载一次配置数据
        self.config_last_loading_time = time.time()
        self.global_monitor_dic = {}
        self.exit_flag = False
        if connect_redis:
            self.redis = redis_conn.redis_conn(django_settings)

    #检测所有主机需要监控的服务的数据有没有按时汇报上来，只做基本检测
    def looping(self):
        #生成全局的监控配置dict,把所有主机和要服务放入一个字典里。
        self.update_or_load_configs()
        count = 0
        while not self.exit_flag:
            print("looping %s".center(50,'-') % count)
            count += 1
            #只有过了配置更新时间才会重新加载配置,这样避免多次加载
            if time.time() - self.config_last_loading_time >= self.config_update_interval:
                print("\033[41;1mneed update configs ...\033[0m")
                self.update_or_load_configs()
                print("monitor dic",self.global_monitor_dic)

            #如果配置字典里面有数据
            if self.global_monitor_dic:
                for h,config_dic in self.global_monitor_dic.items():
                    print('handling host:\033[32;1m%s\033[0m' %h)
                    for service_id,val in config_dic['services'].items():#循环所有要监控的服务
                        service_obj,last_monitor_time = val
                        # 当前时间 - 最后加载配置时间  大于   监控间隔，那么就需要开始检测该服务的最近汇报的数据，并将当前时间复制给最后一次更新时间
                        #意思就是从这里开始，大于监控间隔时间了，我就要去redis检查你有没有上报数据
                        if time.time() - last_monitor_time >= service_obj.interval:
                            print("\033[33;1mserivce [%s] has reached the monitor interval...\033[0m" % service_obj.name)
                            self.global_monitor_dic[h]['services'][service_obj.id][1] = time.time()
                            self.data_point_validation(h,service_obj) #检测此服务最近的汇报数据
                        else:#这个时间内我不需要去检查数据，过了监控间隔再去检查
                            next_monitor_time = time.time() - last_monitor_time - service_obj.interval
                            print("service [%s] next monitor time is %s" % (service_obj.name,next_monitor_time))
            time.sleep(self.poll_interval)




    #只有在这里进行基本的数据验证，如果客户机没有在配置的时间间隔内向服务器报告数据，就会发出警报。
    def data_point_validation(self,host_obj,service_obj):
        service_redis_key = "StatusData_%s_%s_latest" %(host_obj.id,service_obj.name) #拼出此服务在redis中存储的对应key
        latest_data_point = self.redis.lrange(service_redis_key,-1,-1)
        if latest_data_point:#data list is not empty
            latest_data_point = json.loads(latest_data_point[0].decode()) #这里就是redis列表里面的数据，下标为0是因为这个列表里面一个列表
            print("\033[41;1mlatest data point\033[0m %s" % latest_data_point)
            latest_service_data,last_report_time = latest_data_point

            #服务的间隔时间  +   宽容时间    =    监控间隔,      因为有时候因为网络延迟等问题，这里设置了一个宽容时间
            monitor_interval = service_obj.interval + self.django_settings.REPORT_LATE_TOLERANCE_TIME
            if time.time() - last_report_time > monitor_interval: #超过监控间隔但数据还没汇报过来,something wrong with client
                no_data_secs =  time.time() - last_report_time
                msg = '''Some thing must be wrong with client [%s] , because haven't receive data of service [%s] \
                for [%s]s (interval is [%s])\033[0m''' %(host_obj.ip_addr, service_obj.name,no_data_secs, monitor_interval)
                #那么就把消息发送到告警中心
                self.trigger_notifier(host_obj=host_obj,trigger_id=None,positive_expressions=None,msg=msg)
        else:
            print("\033[41;1m no data for serivce [%s] host[%s] at all..\033[0m" %(service_obj.name,host_obj.name))
            msg = '''no data for serivce [%s] host[%s] at all..''' %(service_obj.name,host_obj.name)
            self.trigger_notifier(host_obj=host_obj,trigger_id=None,positive_expressions=None,msg=msg)




    '''
    从redis db获取服务数据并根据每个service的触发器配置进行计算是否告警
   '''
    def load_service_data_and_calulating(self,host_obj,trigger_obj,redis_obj):
        #这里的redis要给ExpressionProcess类的load_data_from_redis 取数据使用
        self.redis = redis_obj
        #存储所有表达式的返回结果,先把每个expression的结果算出来放在这个列表里（每个表达式计算之后返回一个字典 True avg None）
        calc_sub_res_list = []
        positive_expressions = []

        #这里字符串拼接的最后结果为False and False or True
        expression_res_string = ''
        #因为Trigger_expression反向关联expression,所以通过for的方式取出触发器里面的表达式，
        #因为是for循环，然后每一次循环将单条表达式的值交给类ExpressionProcess 去处理获取返回值
        for expression in trigger_obj.triggerexpression_set.select_related().order_by('id'):
            #expression = <TriggerExpression: LinuxCpu.system.system gt(avg(10,3))> expression是一条具体的表达式
            print ('expression:',expression,'expression.logic_type:',expression.logic_type)
            '''
            这里在初始化一个类实例，这个类有可以计算单条表达式的方法
            将本身这个DataHandler实例传入进入，因为这个实例有写参数还有用，比如redis连接
          '''
            expression_process_obj = ExpressionProcess(self,host_obj,expression)
            #得到单条expression表达式的结果一个字典,结果为True(平均数与阀值比较之后的结果)  平均数  特定监控指标(eth0)或者None
            single_expression_res = expression_process_obj.process()
            if single_expression_res:
                calc_sub_res_list.append(single_expression_res)
                '''
                下面还接一个if判断是为了把True或者Flase  以及and的值提取出来并且拼接起来
                expression_obj.logic_type = or and
                如果有这个值，达标这个expression不是最后一条，还有条件and或者or判断
                不管有或者没有and或者or,都需要把这条语句拼接为eval能计算的格式
              '''
                if single_expression_res['expression_obj'].logic_type:
                    expression_res_string += str(single_expression_res['calc_res']) + ' ' + \
                                             single_expression_res['expression_obj'].logic_type + ' '
                else:
                    expression_res_string += str(single_expression_res['calc_res']) + ' '

                #把所有结果为True的expression提出来,报警时你得知道是谁出问题导致trigger触发了
                if single_expression_res['calc_res'] == True:
                    single_expression_res['expression_obj'] = single_expression_res['expression_obj'].id#要存到redis里,数据库对象转成id
                    #把结果加入到一个全部为真的列表里面
                    positive_expressions.append(single_expression_res)

        print("whole trigger res:", trigger_obj.name,expression_res_string)
        if expression_res_string:
            trigger_res = eval(expression_res_string)
            print("whole trigger res:", trigger_res )
            if trigger_res:#终于走到这一步,该触发报警了
                print("##############trigger alert:",trigger_obj.severity,trigger_res)
                self.trigger_notifier(host_obj,trigger_obj.id,positive_expressions,msg=trigger_obj.name)#msg 需要专门分析后生成, 这里是临时写的

    #从数据库中加载监控配置
    def update_or_load_configs(self):

        #获取所有的主机对象
        all_enabled_hosts = models.Host.objects.all()

        for h in all_enabled_hosts:
            #如果主机对象不在这个字典里面，就开始生成一个字典，key为该主机
            if h not in self.global_monitor_dic: #new host
                self.global_monitor_dic[h] = {'services':{},'triggers':{}}
                '''self.global_monitor_dic ={
                    'h1':{'services'{'cpu':[cpu_obj,0],
                                     'mem':[mem_obj,0]
                                     },
                          'trigger':{t1:t1_obj,}
                        }
                }'''
            #声明两个列表一个存储service，一个存储触发器
            service_list = []
            trigger_list = []
            #开始循环主机主，把主机组的模版和触发器先extend进上面的2个列表里
            for group in h.host_groups.select_related():
                for template in group.templates.select_related():
                    service_list.extend(template.services.select_related())
                    trigger_list.extend(template.triggers.select_related())

                #开始循环service_list,如果这个服务的服务id没有生成，就生成字典。 service,0 就是计时器,这里主要是为了生成计时器
                for service in service_list:
                    if service.id not in self.global_monitor_dic[h]['services']:
                        self.global_monitor_dic[h]['services'][service.id] = [service,0]
                    else:
                        self.global_monitor_dic[h]['services'][service.id][0] = service
                for trigger in trigger_list:
                    self.global_monitor_dic[h]['triggers'][trigger.id] = trigger
                #print(self.global_monitor_dic[h])
                #通过这个时间来确定是否需要更新主机状态
                self.global_monitor_dic[h].setdefault('status_last_check',time.time())
        self.config_last_loading_time = time.time()
        return True

    #所有触发的报警都要在这里发布到redis频道里面
    def trigger_notifier(self,host_obj,trigger_id, positive_expressions,redis_obj=None,msg=None):
        if redis_obj:#从外部调用 时才用的到,为了避免重复调用 redis连接
            self.redis_obj = redis_obj
        print("\033[43;1mgoing to send alert msg to trigger queue............\033[0m")
        print('trigger_notifier argv:',host_obj,trigger_id, positive_expressions,redis_obj)
        msg_dic = { 'host_id':host_obj.id,
                    'trigger_id':trigger_id,
                    #等会redis发布为什么不用json而用pickle，就是因为这里存储是数据库对象，json无法解析
                    'positive_expressions':positive_expressions,
                    'msg':msg,
                    'time':time.strftime("%Y-%m-%d %H:%M:%S",time.localtime()),
                    'start_time':time.time() ,
                    'duration':None
                }
        self.redis.publish(self.django_settings.TRIGGER_CHAN,pickle.dumps(msg_dic))
        #这里就是把告警信息给单独的告警模块，告警模块暂时未完成




#这个类主要计算单条表达式的结果,被DataHandler类调用
class ExpressionProcess(object):
    '''
    self，这里的self就是自己，main_ins就是传入的DataHandler实例,
    '''
    def __init__(self,main_ins,host_obj,expression_obj,specified_itme=None):
        self.host_obj = host_obj
        self.expression_obj = expression_obj
        self.main_ins = main_ins
        self.service_redis_key = "StatusData_%s_%s_latest" %(host_obj.id,expression_obj.service.name)
        self.time_range = self.expression_obj.data_calc_args.split(',')[0]#获取要从redis中取多长时间的数据,单位为minute

        print("\033[31;1m------>%s\033[0m" % self.service_redis_key)


    #根据表达式的配置，从redis加载数据,且判断出哪些是在我们比如我要10分钟内多少次的准确数据
    def load_data_from_redis(self):
        time_in_sec = int(self.time_range) * 60 #表示在多少分钟内数据怎么样就报警的参数
        #下面的+60是默认多取一分钟数据,宁多勿少,多出来的后面会去掉,取出一个大概的值
        approximate_data_points = (time_in_sec + 60 ) / self.expression_obj.service.interval#多长时间汇报一次值的间隔时间
        print("approximate dataset nums:", approximate_data_points,time_in_sec)
        #取出redis里面最后这个范围的值出来，data_range_raw的值是一个列表包含一个字典和时间戳,然后一条字典和时间戳生成一个列表放入一个大列表里
        data_range_raw = self.main_ins.redis.lrange(self.service_redis_key,-int(approximate_data_points),-1)
        # print "data_range_raw:",data_range_raw
        #然后转成json格式,可以使用for循环取出数据
        approximate_data_range  = [json.loads(i.decode()) for i in data_range_raw]
        data_range = [] #精确需要的数据，列表
        for point in approximate_data_range:
            val,saving_time = point
            #如果当前时间 -  保存的最后时间   <  要计算的多少时间内时间,那么才代表数据有效
            if time.time() - saving_time < time_in_sec:
                #然后在将这个时间段有效的数据追加进入 data_range里面
                data_range.append(point)

        return data_range


    #处理单条表达式的函数,将结果封装成为一个字典返回
    def process(self):
        #已经按照用户的配置把数据 从redis里取出来了, 比如 最近5分钟,或10分钟的数据,和redis里面的格式一样
        data_list = self.load_data_from_redis()
        #该值为数据处理方式,data_calc_func = self.get_avg...
        data_calc_func = getattr(self,'get_%s' % self.expression_obj.data_calc_func)
        '''
        将redis出去来的值放入data_calc_func里面去处理然后得到单条表达式的返回值
        会得到三个返回值 True(平均数与阀值比较之后的结果)  平均数  特定监控指标(eth0)或者None
       '''
        single_expression_calc_res = data_calc_func(data_list)
        print("---res of single_expression_calc_res ",single_expression_calc_res)
        if single_expression_calc_res:#确保上面的条件 有正确的返回
            res_dic = {
                'calc_res': single_expression_calc_res[0],
                'calc_res_val': single_expression_calc_res[1],
                'expression_obj':self.expression_obj,
                'service_item':single_expression_calc_res[2],
            }
            print("\033[41;1msingle_expression_calc_res:%s\033[0m" % single_expression_calc_res)
            return res_dic
        else:
            return False

    #返回给定数据的平均值，比如cpu的iowait，network的eth0网卡的t_in
    def get_avg(self,data_set):
        #声明一个列表存储如cpu的iowait等值，等会计算平均值的时候就是对临时列表里面的值进行计算
        clean_data_list = []
        #声明一个字典存储如network的值
        clean_data_dic = {}

        for point in data_set:
            val,save_time = point

            #由于有时候第一次redis是没有数据，但是只存储了一个时间戳进去，所以要判断是否有数据在里面
            if val:
                if 'data' not in val:#没有子dic,那么就不是network等服务，而是cpu等服务
                    #service_index.key= iowait,idle等值
                    # print 'lizexiong',val
                    #这里只需要单项服务，如iowait，free的值，然后把这些值加入到列表里面
                    clean_data_list.append(val[self.expression_obj.service_index.key])
                else:
                    for k,v in val['data'].items():
                        #如果字典里面没有这个值，首先声明,因为字典特性，没有的话会报错
                        if k not in clean_data_dic:
                            clean_data_dic[k] = []#k就是eth0,eth1等
                        '''
                        这里clean_data_dic[eth0].append(t_out),这里把t_out和t_in的值都加起来了
                     '''
                        clean_data_dic[k].append(v[self.expression_obj.service_index.key])

        #一定要clean_data_list有数据，因为下面计算  除法  的时候，没有数据会报错
        if clean_data_list:
            #因为存储在clean_data_list里面的值是字符串的数字类型，为了计算，先转换成float
            clean_data_list = [float(i) for i in clean_data_list]
            #计算如iowait这段时间内的平均值
            avg_res = sum(clean_data_list) /len(clean_data_list)
            print("\033[46;1m----avg res:%s\033[0m" % avg_res)

            '''
            计算出平均值，现在就要跟阀值来进行比较，判断是否需要告警,然后将判断的值，然后平均值返回
            返回格式为  True,3.00,None这种样式,True 为judge的判断结果,3.00为平均数,None为service_item(没啥用)
          '''
            return [self.judge(avg_res),avg_res,None]
        elif clean_data_dic:
            for k,v in clean_data_dic.items():
                #还是把v的值变成float
                clean_v_list = [float[i] for i in v]
                avg_res = 0 if sum(clean_v_list) == 0 else sum(clean_v_list) / len(clean_v_list)
                print("\033[46;1m-%s---avg res:%s\033[0m" % (k,avg_res))
                if self.expression_obj.specified_index_key:#监控了特定的指标,比如有多个网卡,但这里只特定监控eth0
                    if k == self.expression_obj.specified_index_key:#就是监控这个特定指标,match上了
                        #判断是否超过阀值
                        calc_res = self.judge(avg_res)
                        if calc_res:
                            return [calc_res,avg_res,k] #后面的循环不用走了，反正已经成立了一个,因为这里就这么一个条件,没必要在判断了
                else:#监控这个服务 的所有项, 比如一台机器的多个网卡, 任意一个超过了阈值,都 算是有问题的
                    calc_res = self.judge(avg_res)
                    if calc_res:
                        return [calc_res,avg_res,k]
                print('specified monitor key:',self.expression_obj.specified_index_key)
                print('clean data dic:',k,len(clean_v_list), clean_v_list)
            else: #能走到这一步,代表 上面的循环判段都未成立
                return [False,avg_res,k]
        else:#可能是由于最近这个服务 没有数据 汇报 过来,取到的数据 为空,所以没办法 判断阈值
            return [False,None,None]

    #此函数将计算的平均数和阀值做比较，然后判断是否为True
    def judge(self,calculated_val):
        calc_func =  getattr(operator,self.expression_obj.operator_type)
        return calc_func(calculated_val,self.expression_obj.threshold)