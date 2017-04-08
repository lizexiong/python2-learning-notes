#!/usr/bin/env python
#--*-- coding:utf8 --*--

import hashlib

print "***md5***"
hash = hashlib.md5()
hash.update('admin')
print hash.hexdigest()
print "***sha1***"
hash1 = hashlib.sha1()
hash1.update('admin')
print hash1.hexdigest()
print "***以上加密算法虽然依然非常厉害，但时候存在缺陷，即：通过撞库可以反解。所以，有必要对加密算法中添加自定义key再来做加密。***"
hash2 = hashlib.md5('admin')
hash2.update('admin')
print hash2.hexdigest()