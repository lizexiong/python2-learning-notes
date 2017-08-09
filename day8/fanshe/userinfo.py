#!/usr/bin/env python
#--*-- coding:utf-8 --*--

class SqlHelper:

    __static_instance = None

    def __init__(self):
        self.host = '0.0.0.0'
        self.port = '3306'
        self.user= 'lizexiong'
        self.passwd = 'huawei'

    @classmethod
    def instance(cls):
        if cls.__static_instance:
            return cls.__static_instance
        else:
            cls.__static_instance = SqlHelper()
            return cls.__static_instance

    def fetch(self):
        pass

    def remove(self):
        pass
# print id(SqlHelper())
# print id(SqlHelper())
# print id(SqlHelper())
# print id(SqlHelper())

def get_user():
    obj = SqlHelper.instance()
    print id(obj)
    obj.fetch()
    return "get_user"

def del_user():
    obj = SqlHelper.instance()
    return "del_user"

