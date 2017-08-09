#!/usr/bin/env python
#--*-- coding:utf-8 --*--

import threading,time

def run(n):
    semaphore.acquire()
    time.sleep(1)
    print ("运行的线程数: %s" %n)
    semaphore.release()

if __name__ == "__main__":
    num = 0
    semaphore = threading.BoundedSemaphore(3) #最多允许3个线程同时进行
    for i in range(10):
        t = threading.Thread(target=run,args=(i,))
        t.start()