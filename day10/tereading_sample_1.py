#!/usr/bin/env python
#--*-- coding:utf-8 --*--

import threading
import time

def show(arg):
    time.sleep(1)
    print 'threading'+str(arg)


for i in range(10):
    t = threading.Thread(target=show,args=(i,))
    t.setDaemon()
    t.start()

print "主线程结束"