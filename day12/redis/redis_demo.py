#!/usr/bin/env python
#--*-- coding:utf-8 --*--

import redis

class RedisHelper:

        def __init__(self):
            self.__conn = redis.Redis(host='192.168.100.50')
            self.chan_sub = 'fm104.5'
            self.chan_pub = 'fm104.5'

        #发布
        def public(self):
            self.__conn.publish(self.chan_sub,msg)
            return True

        #订阅
        def subscribe(self):
            pub = self.__conn.pubsub()          #打开收音机
            pub.subscribe(self.chan_sub)        #调频道
            pub.parse_response()                #准备接收
            return pub