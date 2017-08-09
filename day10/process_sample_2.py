#!/usr/bin/env python
#--*-- coding:utf-8 --*--

# from multiprocessing import Process
# from multiprocessing import Manager
#
# import time
#
# li = []
#
# def foo(i):
#     li.append(i)
#     print "hi",i
#
# for i in range(10):
#     p = Process(target=foo,args=(1,))
#     p.start()
#
# print "end",li
#
# from multiprocessing import Process,Array,RLock
#
# def foo(lock,temp,i):
#     #将第0个数加100
#
#     lock.acquire()
#     for item in temp:
#         print i,'----->',item
#     lock.release()
#
# lock = RLock()
# temp = Array('i',[11,22,33,44])
#
# for i in range(2):
#     p = Process(target=foo,args=(lock,temp,i,))
#     p.start()

#!/usr/bin/env python
# -*- coding:utf-8 -*-
from  multiprocessing import Process,Pool
import time

def Foo(i):
    time.sleep(2)
    return i+100

def Bar(arg):
    print arg

pool = Pool(5)
#print pool.apply(Foo,(1,))
#print pool.apply_async(func =Foo, args=(1,)).get()

for i in range(10):
    pool.apply_async(func=Foo, args=(i,),callback=Bar)

print 'end'
pool.close()
pool.join()#进程池中进程执行完毕后再关闭，如果注释，那么程序直接关闭。