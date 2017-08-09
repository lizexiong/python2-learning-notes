#!/usr/bin/env python
#--*-- coding:utf-8 --*--

# ######################### 消费者 #########################

import pika

#创建一个连接句柄
connection = pika.BlockingConnection(pika.ConnectionParameters(host='192.168.100.50'))

#创建一个连接rabbit的通道
channel = connection.channel()

#定义取队列的名称，消费者本可以不用定义，但是如果是消费者先请求数据那么如果生活者还没有出现就会报错
channel.queue_declare(queue='hello')

#通知消息持久化
channel.queue_declare(queue='hello', durable=True)

#取出队列里面的数据，body就是取出的数据
def callback(ch, method, properties, body):
    print "Received %r" %body #%r给字符串加上引号
    import time
    time.sleep(10)
    print 'ok'
    ch.basic_ack(delivery_tag = method.delivery_tag)

#启动函数
channel.basic_consume(
                    callback,
                    queue='hello',
                    no_ack=False
)

print "Please Wait Output..."
channel.start_consuming()