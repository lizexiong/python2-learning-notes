#!/usr/bin/env python
#--*-- coding:utf-8 --*--

import pika,sys

connection = pika.BlockingConnection(pika.ConnectionParameters(host='192.168.100.50'))

channel = connection.channel()

#定义exchange类型为关键字
channel.exchange_declare(exchange='topic_logs',type='topic')

message = 'tianqingsedengyanyu'

channel.basic_publish(
                exchange='topic_logs',
                routing_key='old.boy.cnf', #这里定于的就是关键字
                body=message
)

print '[Send] %r' %message
connection.close()