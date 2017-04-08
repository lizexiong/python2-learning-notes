#!/usr/lib/env python
#--*-- coding:utf8 --*--



# def login(token):
# #这里是要对比的key
#     key='lizexiong'
#     if key == token:
#         return True
#     else:
#         return False
#
# def auth(func):
#     def inner(*i,**j):
# #这里取出字典的key来做判断
#         k = j["token"]
# #因为def f3是没有传入参数的，如果这里
# #传入参数会报错，所以这里一定要用完删掉这个参数
#         del j["token"]
# #接受login返回的值来做判断
#         is_login=login(k)
#         if not is_login:
#             return "密钥错误"
#         temp=func(*i,**j)
#         return temp
#     return inner
#
# @auth
# def f3():
#     server_list=['c1','c2','c3']
#     return server_list
#
# key="lizexiong"
# #这里是传入的字典，也顺便讲解了字典的传入方法
# a=f3(token=key)
# print a
# # def auth1(func):
# #     def inner():
# #         print "f2"
# #         func(xargs)
# #     return inner
# #
# @auth
# def f1():
#     print "f1"
#
# @auth
# def f2(xargs):
#     print "f2",xargs
# #
# # # f1=auth(f1)
# f1()
# f2('192.168.1.1')


# a= ret()
# b=a
# f2=b
# auth(f2)

#多层装饰器
# def w1(func):
#     def inner():
#         print "开始====="
#         func()
#         print "结束====="
#     return inner
#
# def w2(func):
#     def inner():
#         print "开始==="
#         func()
#         print "结束==="
#     return inner
#
# @w1
# @w2
# def f1():
#     print "半城烟沙"
#
# f1()

#三层装饰器正文

# def before(request,kargs):
#     print "beforce"
#
# def after(request,kargs):
#     print "after"
#
# def filter(before_func,after_func):
#     def outer(main_func):
#         def wrapper(request,kargs):
#
#             before_result = before_func(request,kargs)
#             #print before_result
#             if (before_result != None):
#                 return before_result
#
#             main_result = main_func(request,kargs)
#             if main_func != None:
#                 return main_result
#
#             after_result = after_func(request,kargs)
#             if after_result != None:
#                 return after_result
#
#         return wrapper
#     return outer
#
# @filter(before,after)
# def index(request,kargs):
#     print "最美的不是下雨天，而是与你躲过雨的屋檐"
#
# index(2,2)



def a(request,kargs):
    print "a"

def b(request,kargs):
    print "b"

def there(aa,bb):
    def two(cc):
        def inner(request,kargs):
            d = aa(request,kargs)
            if d  != None:
                return d
            result= cc(request,kargs)
        return inner
    return two

@there(a,b)
def index(request,kargs):
    print "index"

index(2,2)


