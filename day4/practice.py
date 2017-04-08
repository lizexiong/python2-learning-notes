#!/usr/lib/env python
#--*-- coding:utf8 --*--

"""
练习yield的使用,这里使用的是另一种方式，yield就是记录上一次的返回，，如果换成
return，那么就一直返回第一值,且使用for循环会报错
"""

# def func():
#     for i in xrange(10):
#         if i >10:
#            break
#         else:
#            yield i
#
# for i in func():
#     print i
#
# func1=func()
# print func1


"""
本节练习装饰器的使用,主要的部分在于wall()函数以及
login函数。
"""


def wall(i):
    if login("lizexiong"):
        return i

def login(user):
    if user == "lizexiong":
        return True
    else:
        print "login faid"

@wall
def home():
    print "This is a home page"

def user_list():
    print "This is a user_list"

home()