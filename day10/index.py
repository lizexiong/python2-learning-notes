#!/usr/bin/env python
#--*-- coding:utf-8 --*--

from events import event_drive

class MyClass(event_drive.BaseHandler):
    def execute(self):
        print "事件驱动框架测试"

event_drive.event_list.append(MyClass)
event_drive.run()