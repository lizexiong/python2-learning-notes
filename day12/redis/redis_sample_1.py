#/usr/bin/env python
#!--*-- coding:utf-8 --*--

import redis

pool = redis.ConnectionPool(host='192.168.100.50',port=6379)

r = redis.Redis(connection_pool=pool)
r.set('foo','Bar')
print r.get('foo')