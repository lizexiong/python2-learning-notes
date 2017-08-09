#!/usr/bin/env python
#--*-- coding:utf-8 --*--


from multiprocessing import Process

import threading
import time

def foo(i):
    print "hi ",i

for i in range(10):
    p = Process(target=foo,args=(i,))
    p.start()