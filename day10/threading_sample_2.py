#!/usr/bin/env python
#--*-- coding:utf-8 --*--

import threading
import time

gl_num = 0

lock = threading.RLock()

def Func():
    #加锁
    lock.acquire()
    #转换为全局参数
    global gl_num
    gl_num += 1
    time.sleep(1)
    print gl_num
    # 解锁
    lock.release()

for i in range(10):
    t = threading.Thread(target=Func)
    t.start()
