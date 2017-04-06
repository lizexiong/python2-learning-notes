#!/usr/bin/env python
#--*-- coding:utf8 --*--



"""
这里才是第二个模块，定义了一个我们装饰器要直接引用的函数，
有一个返回值，返回值等会返回一个函数，
做一个判断，判断函数login()是否为正确的用户名。
"""
def wall(i):
    if login("lizexiong"):
        return i

"""
这里为第一步，定义了一个login的模块，
如果用户登录lizexiong,那么返回true，否则，返回打印失败

最后一个执行流程在这里，如果wall(home),那么就调用了home()函数，如果login()函数成功了，
那么才回返回home()的内容
"""
def login(user):
    if user == "lizexiong":
        return True
    else:
        print "login fald"
        
"""
这里为第三步。这里就是函数，等于home=wall(home),但是没有必要写这么麻烦的方法
且下面开始，全是可以说不能动的函数模块，所以，这里主要是上面
wall（）和 login（）
"""
@wall
def home():
    print "This is a home pag"

def user_list():
    print "This is user_list"

home()