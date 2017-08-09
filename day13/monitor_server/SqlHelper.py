#!/usr/bin/evn python
#--*-- coding:utf-8 --*--

import redis

class RedisHelper():
    def __init__(self):
        self.__conn = redis.Redis(host='192.168.100.50',port='6379')
        self.__channel = 'yy104.1'

    def get(self,key):
        return self.__conn.get(key)

    def set(self,key,value):
        return self.conn.set(key,value)

    def set_ex(self,key,value,expire):
        return self.__conn.set(name=key,value=value,ex=expire)

    def delete(self,key):
        self.__conn.delete(key)

    def publish(self,msg):
        self.__conn.publish(self.__channel,msg)

    def subscribe(self):
        pub = self.__conn.pubsub()
        pub.subscribe(self.__channel)
        pub.parse_response()
        return pub