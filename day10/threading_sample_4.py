#!/usr/bin/env python
#--*-- coding:utf-8 --*--

# import threading
#
# def do(event):
#     print "start"
#     event_obj.wait()
#     print "结束"
#
# event_obj = threading.Event()
# for i in range(5):
#     t = threading.Thread(target=do,args=(i,))
#     t.start()
#
# #设置False
# event_obj.clear()
#
# inp= raw_input("请输入True/False")
# if inp == 'True':
#     event_obj.set()

import threading

def run(n):
    con.acquire()
    con.wait()
    print("run the thread: %s" %n)
    con.release()

if __name__ == '__main__':

    con = threading.Condition()
    for i in range(10):
        t = threading.Thread(target=run, args=(i,))
        t.start()

    while True:
        inp = input('>>>')
        if inp == 'q':
            break
        con.acquire()
        con.notify(int(inp))
        con.release()