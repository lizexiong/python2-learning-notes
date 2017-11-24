#_*_coding:utf-8_*_
__author__ = 'Alex Li'

import pika,json

class TaskHandle(object):
    '''
    generate task
    '''
    def __init__(self,db_model,task_data,settings,module_obj):
        self.db_model = db_model
        self.task_data = task_data
        self.settings = settings
        self.module_obj = module_obj#这里就是传进来的self，哪个模块调用我，这个变量就是谁，刚才是state调用的TaskHandler，那么self就是state模块
        self.make_connection()#创建Q的连接
    def apply_new_task(self):
        '''
        create a task record in db and return the task id
        使用数据库自增id作为唯一标识id
        :return:
        '''

        #下面直接操作数据库Task表，没调用一次生成一个taskid，但是里面没有存储值
        new_task_obj = self.db_model.Task()
        new_task_obj.save()
        self.task_id = new_task_obj.id
        return True
    def dispatch_task(self):
        '''
        format the task data and make it ready to sent
        格式化任务数据并准备发送
        :return:
        '''
        if self.apply_new_task():#得到一个task id,任务编号申请成功
            #往哪些主机里面发消息
            print('send task to :',self.module_obj.host_list)
            #客户端执行的结果返回到下面的q里面
            self.callback_queue_name = "TASK_CALLBACK_%s" % self.task_id
            #下面字典就是发给客户端的数据
            data = {
                'data':self.task_data,
                'id': self.task_id,
                'callback_queue': self.callback_queue_name,
                #这个客户端和服务器的认证，但是还没有做
                'token':None
            }
            print ('data-----------------------------',data)
            #循环所有要发的主机，把数据发送给主机
            for host in self.module_obj.host_list:
                self.publish(data,host)

            #开始等待任务结果
            self.wait_callback()
    def make_connection(self):
        #创建一个Q的连接
        username = self.settings.MQ_CONN['username']
        password = self.settings.MQ_CONN['password']
        user_pwd = pika.PlainCredentials(username,password)
        print ('user_pwd',user_pwd)
        self.mq_conn = pika.BlockingConnection(pika.ConnectionParameters(
                       self.settings.MQ_CONN['host'],credentials=user_pwd))
        #生成一个频道，往频道里面发东西
        self.mq_channel = self.mq_conn.channel()

    def publish(self,task_data,host):
        print('\033[41;1m-----going to publish msg ------\033[0m;\n')

        #声明queue,发到哪个q，发给主机的时候是每个主机一个q。
        queue_name = 'TASK_Q_%s' %host.id
        #声明一个q
        self.mq_channel.queue_declare(queue=queue_name)
        print(json.dumps(task_data).encode())

        #n RabbitMQ a message can never be sent directly to the queue, it always needs to go through an exchange.
        #这一步就是把数据发过去。
        self.mq_channel.basic_publish(exchange='',
                              routing_key=queue_name,
                              body= json.dumps(task_data))
        print(" [x] Sent task to queue [%s] 'Hello World!'" % queue_name)

    def close_connection(self):
        self.mq_conn.close()

    def task_callback(self,ch, method, properties, body):
        print(body)
    def wait_callback(self):
        '''
        get task callback
        :return:
        '''
        #print('------waiting for callback from :' ,self.callback_queue_name)

        #服务端现在在q里客户端返回的结果，那么还得声明一个q
        self.mq_channel.queue_declare(queue=self.callback_queue_name)
        #开始消费,从喜爱面的quequ里面监听消息，且只有要消息过来就执行self.task_callback函数，no_ack这条消息收到之后不会想客户端返回确认收到消息
        self.mq_channel.basic_consume(self.task_callback,
                              queue=self.callback_queue_name,
                              no_ack=True)

        print('\033[42;1m[%s] Waiting for callback. To exit press CTRL+C\033[0m' % self.callback_queue_name)
        #开始进入阻塞状态
        self.mq_channel.start_consuming()