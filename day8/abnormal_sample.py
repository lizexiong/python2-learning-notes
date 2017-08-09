#!/usr/bin/env python
#--*-- coding:utf-8 --*--

# while True:
#     num1= raw_input("Please 1")
#     num2= raw_input("Please 2")
#     try:
#         num1 = int(num1)
#         num2 = int(num2)
#         result = num1 + num2
#     except Exception, i:
#         print "信息出错，异常如下"
#         print i


# 列表
# dic = ["lizexiong",'wuxinzhe']
# try:
#     dic[2]
# except IndexError,i:
#     print i

#字典
# dic = {'name':'lizexiong' , 'age':24}
# try:
#     dic['name1']
# except KeyError,i:
#     print "error:",i

#值
# s = "Hello"
# try:
#     int(s1)
# except KeyError,i:
#     print "键错误"
# except IndexError,i:
#     print "索引错误"
# except Exception,i:
#     print "错误"


# #异常的其它结构
# if __name__ == '__main__':
#     try:
#         #主代码块
#         n = "s"
#         n = int(n)
#     except Exception,i:
#         print "异常时，输出此代码块"
#     else:
#         #主代码块执行完成，执行该块
#         print "代码正常，输出此块"
#     finally:
#         #无论正常与否，都执行该块
#         print "不管结果如何，finally都要打印。"

#主动触发异常
# if __name__ == '__main__':
#     try:
#         n="s"
#         n=int(n)
#         if n:
#             raise Exception("这里是主动异常")
#         else:
#             print "打印出"
#     except Exception,i:
#         print "这里输出是为了提示，我不是Exception后面的i变量"
#         print i


#自定义异常

"""
try:
    int('lizexiong')
except Exception,i:
    print i
"""

# class A:
#     def __str__(self):
#         return "lizexiong"
#
# obj=A()
# print obj

class lizexiongError(Exception):
    def __init__(self,msg=None):
        self.message=msg

    def __str__(self):
        if self.message:
            return self.message
        else:
            return "返回为空"

try:
    raise lizexiongError("天青色等烟雨")
except Exception,i:
    print i