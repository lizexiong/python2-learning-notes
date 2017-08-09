#!/usr/bin/env python
#--*-- coding:utf-8 --*--

import redis

pool = redis.ConnectionPool(host='192.168.100.50',port=6379)

r = redis.Redis(Connection_pool=pool)

