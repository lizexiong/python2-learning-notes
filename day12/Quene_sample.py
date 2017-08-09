#!/usr/bin/env python
#--*-- coding:utf-8 --*--

import Queue,threading

message = Queue.Queue(10)

def producer(i):
    while True:
        message.put(i)

def consumer(i):
    while True:
        msg = message.get()
        print "This is a ",msg

for i in range(5):
    t = threading.Thread(target=producer,args=(i,))
    t.start()

for i in range(1):
    t = threading.Thread(target=consumer,args=(i,))
    t.start()