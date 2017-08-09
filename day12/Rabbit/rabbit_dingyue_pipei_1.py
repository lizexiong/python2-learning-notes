#!/usr/bin/env python
#--*-- coding:utf-8 --*--

import pika

connection = pika.BlockingConnection(pika.ConnectionParameters(host='192.168.100.50'))
channel = connection.channel()

#定义exchange模式为匹配
channel.exchange_declare(exchange='topic_logs',type='topic')

result = channel.queue_declare(exclusive=True)
queue_name = result.method.queue

#定义关键字为lizexiong和wuxinzhe，客户端里面如果不使用for来去列表值，只能创建2个bind列表
channel.queue_bind(exchange='topic_logs',
                    queue=queue_name,
                    routing_key='old.#'
                   )

def callback(ch, method, properties, body ):
    #打印出关键字和队列消息
    print "[guanjian] %r %r" %(method.routing_key,body)

channel.basic_consume(
                    callback,
                    queue = queue_name,
                    no_ack = True
)

channel.start_consuming()