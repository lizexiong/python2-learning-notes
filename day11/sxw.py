#!/usr/bin/env python
#--*-- coding:utf-8 --*--

# import Queue
#
# q = Queue.Queue()
#
# obj = object()
# for i in range(10):
#     q.put(obj)
#     print id(obj)

import Queue,contextlib,threading,time,random

ii = []
#把ii传入进去，一直打印ii的长度
def num(i):
    while True:
        print len(i),'for'
        time.sleep(1)
t = threading.Thread(target=num,args=(ii,))
t.start()

@contextlib.contextmanager
def show(i,j):
    print len(ii),'first beforce'
    ii.append(j)
    yield
    print len(ii),'two beforce end'
    ii.remove(j)

def task():
    with show(ii,1):
        # print "天青色等烟雨"
        time.sleep(random.randint(1,1))

for i in range(10):
    temp = threading.Thread(target=task)
    temp.start()