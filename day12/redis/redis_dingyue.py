#!/usr/bin/env python
#--*-- coding:utf-8 --*--

from redis_demo import RedisHelper

obj = RedisHelper()
redis_sub = obj.subscribe()

while True:
    #接收消息
    msg = redis_sub.parse_response()
    print msg