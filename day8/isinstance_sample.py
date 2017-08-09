#!/usr/bin/env python
#--*-- coding:utf-8 --*--

# 检查是否obj是否是类 cls 的对象

class foo:
    pass

obj=foo()
i=1
s='lizexiong'


print isinstance(obj, foo )
print isinstance(i, foo)
print isinstance(s, str)
print isinstance(s, int)