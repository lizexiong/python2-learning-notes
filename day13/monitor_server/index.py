#!/usr/bin/evn python
#--*-- coding:utf-8 --*--

from SqlHelper import *

obj = RedisHelper()
redis_sub = obj.subscribe()

while True:
    msg = redis_sub.parse_response()
    print msg