#!/usr/bin/env python
#--*-- coding:utf-8 --*--

# ######################### 生产者 #########################

import pika

#创建一个连接句柄
connection = pika.BlockingConnection(pika.ConnectionParameters(host='192.168.100.50'))

#创建一个连接rabbit的通道
channel = connection.channel()

#队列消息持久化
channel.queue_declare(queue='hello',durable=True)

#定义一个队列名称
channel.basic_publish(
                        exchange='',
                        routing_key='hello',      #队列名称
                        body = "Hello World",  #这里是要往消息队列里面插入的内容
                        properties=pika.BasicProperties(
                          delivery_mode=2, # make message persistent
))

print "Send 'hello World' "
connection.close()
