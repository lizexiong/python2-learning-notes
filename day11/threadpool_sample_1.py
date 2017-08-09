#!/usr/bin/env python
#--*-- coding:utf-8 --*--

import threading,Queue

class ThreadPool(object):

    def __init__(self,max_num=20):#这里的20是默认值
        self.queue = Queue.Queue(max_num)
        for i in xrange(max_num):
            self.queue.put(threading.Thread()) #这里put创建的是类，而不是对象，类在内存只保留一份

    def get_thread(self):
        return self.queue.get()

    def add_thread(self):
        return self.queue.put(threading.Thread())

#如果这里不设置，那么默认就是20
pool = ThreadPool(10)

def func(arg,p):
    print arg
    import time
    time.sleep(2)
    p.add_thread()

for i in xrange(20):
    #这个线程是自己创建的
    thread = pool.get_thread()
    # t= thread(target=func,args=(i,pool))
    # t.start()
    thread._Thread__target = func
    thread._Thread__args = (i,pool)
    thread.start()


