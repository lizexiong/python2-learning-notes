#!/usr/bin/env python
#--*-- coding:utf-8 --*--

import home
import userinfo

print "-------- 宿敌 ----------"

# url = raw_input("输入URL：")
# if url == "home/index":
#     ret = home.index()
#     print ret
# elif url == "home/dev":
#     ret = home.dev()
#     print ret
# else:
#     print 404

# url = raw_input("输入URL：")
# controller, action =url.split('/')
#
# if hasattr(home,action):
#     func = getattr(home,action)
#     func =func()
#     print func
# else:
#     print 404



# from wsgiref.simple_server import make_server
#
# def RunServer(environ, start_response):
#     start_response('200 OK', [('Content-Type', 'text/html')])
#     url = environ['PATH_INFO']
# #这里使用直接找出下标的值
#     temp = url.split('/')[1]
#     is_exist = hasattr(home, temp)
#     if is_exist:
#         func = getattr(home, temp)
#         ret = func()
#         return ret
#     else:
#         return '404 not found'
#
# if __name__ == '__main__':
#     httpd = make_server('', 8000, RunServer)
#     print "Serving HTTP on port 8000..."
#     httpd.serve_forever()

# print dir(home)
# # print hasattr(home,'dev')
# # print getattr(home,'dev')
# setattr(home,'lizexiong',lambda :x+1)
# print dir(home)
# delattr(home,'dev')
# print dir(home)

# class Foo():
#     def __init__(self):
#         self.name='lizexiong'
#
#     def show(self):
#         pass
#
#     @staticmethod
#     def show_static():
#         pass
#
#     @classmethod
#     def cls_show(cls):
#         pass
#
# obj=Foo()
# # print Foo.__dict__.keys()
# print obj.__dict__
# print hasattr(obj,'name')
# print hasattr(obj,'show')

# obj = getattr(home,'Foo')
# l=obj()
# name = getattr(l,'name')
# print name

controller,action = raw_input("请输入URL:").split('/')

#将获取分割到的第一个字段变成变量。
module = __import__(controller)

is_exist = hasattr(module,action)

if is_exist:
    func = getattr(module,action)
    print func()
else:
    print "404 not found"