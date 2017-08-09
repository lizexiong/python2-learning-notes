#!/usr/bin/env python
#--*-- coding:utf-8 --*--

import memcache

#debug = True 表示运行出现错误时，现实错误信息，上线后移除该参数。
mc = memcache.Client(['192.168.100.50:11211'],debug=True)
mc.set("foo","Bar")
ret = mc.get('foo')
print ret