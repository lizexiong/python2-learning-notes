#!/usr/bin/env python
#--*-- coding:utf-8 --*--


import memcache

mc = memcache.Client(['192.168.100.50:11211'],debug=True,cache_cas=True)

ret = mc.gets('foo')
print mc.cas_ids
import time
time.sleep(2)
mc.cas('foo','900')
print mc.cas_ids