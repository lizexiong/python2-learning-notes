#!/usr/bin/env python
#--*-- coding:utf-8 --*--


# class SqlHelper:
#
#     def __init__(self,name):
#         self.name='lizexiong'
#         self.name=name
#
#     def show(self):
#         pass
#
# obj1 = SqlHelper(1)
# print id(obj1)
# obj2 = SqlHelper(1)
# print id(obj2)


#单例
class SqlHelper:

    __static_instance = None

    def __init__(self):
        self.name = "127.0.0.1"
        self.port = "3306"

    @classmethod
    def instance(cls):
        if cls.__static_instance:
            return cls.__static_instance
        else:
            cls.__static_instance = SqlHelper()
            return cls.__static_instance

obj1 = SqlHelper.instance()
print id(obj1)
obj2 = SqlHelper.instance()
print id(obj2)