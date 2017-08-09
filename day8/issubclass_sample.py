#!/usr/bin/env python
#--*-- coding:utf-8 --*--

class foo(object):
    pass

class bar(foo):
    pass

print issubclass (bar, foo)