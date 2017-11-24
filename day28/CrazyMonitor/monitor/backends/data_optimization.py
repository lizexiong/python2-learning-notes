# -*- coding: utf-8 -*-




'''
1.DataStore类，在初始化里面有一个process_and_save函数，然后根据这个函数来处理和保存数据。
2.process_and_save函数
    首先判断status == 0 是否合法，如果合法,那么就循环取出要生成的key格式的拼接参数，如latest，10mins,30mins
    通过这些参数，生成redis里面存储的key，然后取出redis这个key的最后一条记录。
        通过这最后一条记录来判断

            如果没有最后一条记录,那么就push一条None值进入，并把当前时间push进入，方便下一次判断,
            如果配置里面的监控间隔时间为0,那么就代表只是实时监控的，直接把值push进入哪个key就可以

        否则不是以上两种结果,那么肯定是300秒，600秒这样检测的参数，那么就
        （因为要求出10mins或者30mins的最大值和最小值等一些值类型）

            当前时间  - 最后一条值的保存时间  >=     字典里面间隔时间，那么就 生成一个key格式lastest_data_key_in_redis = "StatusData_%s_%s_latest" %(self.client_id,self.service_name)和 字典里面间隔时间传入给函数
            data_set  =self.get_data_slice(lastest_data_key_in_redis,data_series_optimize_interval)
            并获取返回值,data_set 是取 10mins，30mins内的所有数据的函数

            如果返回值长度大于0代表有返回值，那么就将10mins或者30mins所有的值传入进入优化
            optimized_data = self.get_optimized_data(data_series_key_in_redis,data_set)
            优化完成后返回数据

            如果有这些数据，那么就把这些值按照生成的rediskey的方式保存到redis里面去。
            self.save_optimized_data(data_series_key_in_redis,optimized_data)

    总结此函数
    1 判断最后一条数据有没有，没有就传一条空的数据进去，并把当前时间也传入进去
    2. 判断配置里面的监控时间是否为0，如果为0,代表这个数据是实时监控的
    3. 如果不是以上两种情况,那么肯定是10mins,30mins这样的值参数，
            然后通过get_data_slice 把当前时间之前的10mins，30mins所有的值全部取出来,并返回
            如果上一条返回有值,那么就要把这些值进行优化，算出最大值，最小值等,然后在返回
            如果优化之后还返回数据,那么就把这些值保存到redis里面去

3.get_data_slice函数  接收redis_key的名字，可能是10mins,也可能是30mins,还有配置里面的间隔时间
        然后把这个redis_key的所有数据全部取出来
        然后开始循环
            如果判断这个数据是10mins内，或者30mins内的数据，那么就append给空列表，然后将至返回

    此函数就是取出当前之前10mins或者30mins内的所有数据的

4.get_optimized_data   接收redis_key的名字，以及get_data_slice的返回值
        此时  get_data_slice的返回值字典里面会有两种结果，一种是如果内存的服务，没有子服务，字典里面没有data这个key，
    还有一个就是network这种，有很多etho，那么就有data这个key
        如果没有data这个key，那么
            将这个值通过循环来取到具体的键值,然后将这些键值放入列表，然后进行最大值最小值计算
        否则
            也是一样的计算方式，只不过去key和键的方式复杂了一点点

        然后最后将计算好的max,min返回
        最后第一个函数会讲这些值存储到redis里面
'''



from CrazyMonitor import settings
import time,json,copy


class DataStore(object):
    '''
    处理客户端报告的服务数据，执行一些数据优化并将其保存到redis DB中
    '''
    def __init__(self,client_id,service_name,data,redis_obj):
        self.client_id = client_id
        self.service_name = service_name
        self.data = data
        self.redis_conn_obj = redis_obj
        #注意，这里有一个处理并保存的函数
        self.process_and_save()

    def get_data_slice(self,lastest_data_key,optimization_interval):
        #取出这个key的所有数据,这里的key可能有10分钟网络的显示，30分钟显示网络的。
        all_real_data = self.redis_conn_obj.lrange(lastest_data_key,1,-1)
        data_set = []
        #这里循环这个key里面的所有数据
        for item in all_real_data:
            data = json.loads(item.decode())
        #因为字典格式为[data,interval_time]，所以这里长度等于2
            if len(data) == 2:
                service_data, last_save_time = data
                # 当前时间  - 最后一起保存时间   <= 间隔时间   表示只这个间隔内的所有数据，然后append给列表，然后返回。
                if time.time() - last_save_time <= optimization_interval:
                    data_set.append(data)
                else:
                    pass
        return data_set

    #处理数据并保存到redis
    def process_and_save(self):
        print("\033[42;1m---service data-----------------------\033[0m")
        if self.data['status'] == 0: #判断客户端发来的数据是否合法
            '''
                STATUS_DATA_OPTIMIZATION = {
                'latest':[0,600], #0 存储真实数据,600个点
                '10mins':[600,600], #4days, 每600s进行一次优化，存最大600个点
                '30mins':[1800,600],#14days
                '60mins':[3600,600], #25days
                }
                循环上面的字典，取出间隔时间个显示点数，
                key =  latest,10mins     data_series_val = [0,600],[600,600]
           '''
            for key,data_series_val in  settings.STATUS_DATA_OPTIMIZATION.items():
                data_series_optimize_interval,max_data_point = data_series_val
                #这里把client_id,service_name,key做个字符串拼接,作为redis的key
                data_series_key_in_redis = "StatusData_%s_%s_%s" %(self.client_id,self.service_name,key)
                #取出redis存储的最后一个值
                last_point_from_redis = self.redis_conn_obj.lrange(data_series_key_in_redis,-1,-1)
                if not last_point_from_redis: #这个键在redis中不存在
                    '''
                    如果没有这个键，那么就代表没有生成,那么我就传递一个空值和时间进入，利于下次判断
                 '''
                    self.redis_conn_obj.rpush(data_series_key_in_redis,json.dumps([None,time.time()]))
                if data_series_optimize_interval == 0:
                    '''
                    如果等于0，那么就是第一次的数据，不需要优化，因为间隔为0秒就取出来，没有必要优化，
                    那么就直接把数据存储进入
                  '''
                    self.redis_conn_obj.rpush(data_series_key_in_redis,json.dumps([self.data,time.time()]))
                else: #如果排除上面两种情况,那么其余的就是要优化的
                    #那么就取出最后一条保存的值和时间
                    last_point_data,last_point_save_time = \
                        json.loads(self.redis_conn_obj.lrange(data_series_key_in_redis,-1,-1)[0].decode())

                    #当前时间  - 最后一条值的保存时间  >=     字典里面间隔时间
                    if time.time() - last_point_save_time >= data_series_optimize_interval:
                        lastest_data_key_in_redis = "StatusData_%s_%s_latest" %(self.client_id,self.service_name)
                        print("calulating data for key:\033[31;1m%s\033[0m" %data_series_key_in_redis )
                        '''
                        最近n分钟的数据 已经取到了,放到了data_set里.
                        把由client_id和 service_name拼接的参数传入到get_data_slice里面去,拼接的参数
                        lastest_data_key_in_redis只是一个redis的key。
                        然后data_set是一个区间内所有的值（该值可能是10分钟内的network，也有可能是30分的memory）
                     '''
                        data_set  =self.get_data_slice(lastest_data_key_in_redis,data_series_optimize_interval)

                        print('--------------------------len dataset :',len(data_set))
                        if len(data_set) >0:
                            #接下来拿这个data_set交给下面这个方法,让它算出优化的结果,比如这个区间平局数，最大值，最小值等
                            #把data_series_key_in_redis 和 data_set = 一个时间段的值传入进去
                            optimized_data = self.get_optimized_data(data_series_key_in_redis,data_set)
                            #如果优化算法算出结果，那么就把结果保存下来
                            if optimized_data:
                                self.save_optimized_data(data_series_key_in_redis,optimized_data)
                #同时确保数据在redis中的存储数量不超过settings中指定 的值
                if self.redis_conn_obj.llen(data_series_key_in_redis) >= max_data_point:
                    self.redis_conn_obj.lpop(data_series_key_in_redis) #删除最旧的一个数据
                #self.redis_conn_obj.ltrim(data_series_key_in_redis,0,data_series_val[1])
        else:
            print("report data is invalid::",self.data)
            raise ValueError

    def save_optimized_data(self,data_series_key_in_redis,optimized_data):
        self.redis_conn_obj.rpush(data_series_key_in_redis, json.dumps([optimized_data, time.time()]))

    def get_optimized_data(self,data_set_key,raw_service_data):
        #计算来自一个区间的最大值，最小值，平均值等
        '''
        data_set = raw_service_data = [[{'status':0,'iowait':1.01,'nice':2.10,'user':'2.11'},1463099230.00],
        [{'status':0,'iowait':1.01,'nice':2.10,'user':'2.11'},1463099230.00]]
        raw_service_data[0] = [{'status':0,'iowait':1.01,'nice':2.10,'user':'2.11'},1463099230.00]
        raw_service_data[0][0]  = {'status':0,'iowait':1.01,'nice':2.10,'user':'2.11'}
        '''
        print("get_optimized_data:",raw_service_data[0] )
        service_data_keys = raw_service_data[0][0].keys() #iowait,nice
        first_service_data_point = raw_service_data[0][0]
        print service_data_keys,'------------------------'
        #设置一个空字典，等会保存优化后的数据
        optimized_dic = {}

        '''
        这里为什么会有 if 'data' in service_data_keys():
        因为客户端发送过来的值，不止只有如cpu的单个参数
        [{'status':0,'iowait':1.01,'nice':2.10,'user':'2.11'},1463099230.00]
        还有多块网快，多块硬盘的参数，那么参数就变成以下
        {{'status':0,"data":{"lo":{"t_in":0.00,'t_out':1.00},"eth0":{"t_in":1.00,"t_out":2.00}}}}
       '''
        if 'data' not in  service_data_keys:
            print "service_data_keys,=========--------",service_data_keys,
            # print "raw_service_data,=========---------",raw_service_data
            for key in service_data_keys:
                #key =  iowait,nice,user
                optimized_dic[key] = []
                # print 'optimized_dic',optimized_dic,'-' * 100
            tmp_data_dic = copy.deepcopy(optimized_dic)  #为了临时存最近n分钟的数据 ,把它们按照每个指标 都 搞成一个一个列表 ,来存最近N分钟的数据
            print("tmp data dic:",tmp_data_dic)
            """
            循环传递进来最近n分钟的总数据,总数据格式raw_service_data为：
            [[{'status':0,'iowait':1.01,'nice':2.10,'user':'2.11'},1463099230.00],
            [{'status':0,'iowait':1.01,'nice':2.10,'user':'2.11'},1463099230.00]]
            service_data_item = {'status':0,'iowait':1.01,'nice':2.10,'user':'2.11'}
            last_save_time = 1463099230.00

          """
            for service_data_item,last_save_time in raw_service_data:#循环传递进来最近n分钟的总数据

                '''
                在循环service_data_item，也就是循环{'status':0,'iowait':1.01,'nice':2.10,'user':'2.11'}
                那么sevice_index = status,iowait
             '''
                for service_index,v in service_data_item.items():
                    try:
                        tmp_data_dic[service_index].append(round(float(v),2)) #把这个点的当前这个指标 的值 添加到临时dict中
                    except ValueError as e:
                        pass
                '''
                现在开始算出平均数，最大值，最小值,此时:tmp_data_dic的值为：
                tmp_data_dic= {"iowait":[1.00,0.12,2.11],"user":[1.21,2.14]}
              '''
            print tmp_data_dic,'========================================='
            for service_k, v_list in tmp_data_dic.items():
                print (service_k,v_list)
                avg_res = self.get_average(v_list)
                max_res = self.get_max(v_list)
                min_res = self.get_min(v_list)
                mid_res = self.get_mid(v_list)
                #将最大值，最小值，平均数存入刚才生成的空字典里面
                optimized_dic[service_k] = [avg_res,max_res,min_res,mid_res]
                print (service_k,optimized_dic[service_k])

        else : #那么就是有子服务，如多个网卡存在的
            '''
            这是数据类型应该为:{{'status':0,"data":{"lo":{"t_in":0.00,'t_out':1.00},"eth0":{"t_in":1.00,"t_out":2.00}}}}
            service_item_key =  lo,eth0,v_dic = {"t_in":0.00,'t_out':1.00}
          '''
            for service_item_key,v_dic in first_service_data_point['data'].items():
                optimized_dic[service_item_key] = {}
                for k2,v2 in v_dic.items():
                    optimized_dic[service_item_key][k2] = []#{etho0:{t_in:[],t_out:[]}}

            tmp_data_dic = copy.deepcopy(optimized_dic) #和上面一样，来一个深拷贝
            if tmp_data_dic:
                print('tmp data dic:', tmp_data_dic)
                for service_data_item,last_save_time in raw_service_data:#循环传递进来最近n分钟的总数据
                    """
                    循环传递进来最近n分钟的总数据,总数据格式raw_service_data为：
                    [{'status':0,"data":{"lo":{"t_in":0.00,'t_out':1.00},"eth0":{"t_in":1.00,"t_out":2.00}}},14020323.00,
                    {'status':0,"data":{"lo":{"t_in":0.00,'t_out':1.00},"eth0":{"t_in":1.00,"t_out":2.00}}}，140232323,02]
                    redis的key是一个列表，里面存储了很多这样的列表，所以循环传入进来的数据集合
                    service_data_item = {'status':0,"data":{"lo":{"t_in":0.00,'t_out':1.00},"eth0":{"t_in":1.00,"t_out":2.00}}}
                    last_save_time = 14020323.00
                  """
                    for service_index,val_dic in service_data_item['data'].items():
                        #service_index这个值 相当于eth0,eth1..
                        for service_item_sub_key,val in val_dic.items():
                            tmp_data_dic[service_index][service_item_sub_key].append(round(float(val),2))

                '''
                现在开始算出平均数，最大值，最小值,此时:tmp_data_dic的值为：
                tmp_data_dic= {'eth0':{"t_in":0.11,"t_out":0.22},"lo":{"t_in":0.11,"t_out":0.22}}
              '''
                for service_k,v_dic in tmp_data_dic.items():
                    for service_sub_k,v_list in v_dic.items():
                        print(service_k, service_sub_k, v_list)
                        avg_res = self.get_average(v_list)
                        max_res = self.get_max(v_list)
                        min_res = self.get_min(v_list)
                        mid_res = self.get_mid(v_list)
                        optimized_dic[service_k][service_sub_k] = [avg_res,max_res,min_res,mid_res]
            else:
                print("\033[41;1mMust be sth wrong with client report data\033[0m")
        print("optimized empty dic:", optimized_dic)
        return optimized_dic


    def get_average(self,data_set):
        #求平均数
        if len(data_set) > 0:
            return sum(data_set)/len(data_set)
        else:
            return 0

    def get_max(self,data_set):
        #求最大值
        if len(data_set) >0:
            return max(data_set)
        else:
            return 0

    def get_min(self,data_set):

        if len(data_set) >0:
            return min(data_set)
        else:
            return 0

    def get_mid(self,data_set):

        data_set.sort()
        #[1,4,99,32,8,9,4,5,9]
        #[1,3,5,7,9,22,54,77]
        if len(data_set) >0:
            return data_set[  int(len(data_set)/2) ]
        else:
            return 0


