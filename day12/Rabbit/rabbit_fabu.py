#!/usr/bin/env python
#--*-- coding:utf-8 --*--

import pika,sys

connection = pika.BlockingConnection(pika.ConnectionParameters('192.168.100.50'))
channel = connection.channel()

channel.exchange_declare(
                    #定义exhcange名称为logs
                    exchange='logs',
                    #type为fatout,这里
                    type= 'fanout'
)

message = 'tianqingsedengyanyu'

channel.basic_publish(
                exchange='logs',#这里生产者消息不在发送到队列，而是发送到exchange里面
                routing_key='',
                body=message
)

print "Send %r" %message
connection.close()