#!/usr/bin/env python
#--*-- coding:utf-8 --*--

import pika

connection = pika.BlockingConnection(pika.ConnectionParameters(host='192.168.100.50'))
channel = connection.channel()

channel.exchange_declare(
                        exchange='logs',
                        type='fanout'
)

result = channel.queue_declare(exclusive=True)
#随机一个队列的名称，不在手动指定，因为以后都是用exchange去取的
queue_name = result.method.queue

#接下来将随机队列名和exchange绑定在一起
channel.queue_bind(
                exchange='logs',
                queue=queue_name
)

def callback(ch, method, properties, body):
    print "[SB] %r" %body

channel.basic_consume(
                    callback,
                    queue=queue_name,
                    no_ack=True
)
channel.start_consuming()