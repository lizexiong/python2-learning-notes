#!/usr/bin/env python
#--*-- coding:utf-8 --*--

import Queue

#obj = Queue.Queue()

# print "前"
# try:
#     print obj.get_nowait()
# except Queue.Empty:
#     print "后"

obj = Queue.Queue(2)
try:
    obj.put(1)
    print 1
    obj.put(2)
    print 2
    obj.put_nowait(3)
    print 3
except Exception:
    print "队列大小越界"