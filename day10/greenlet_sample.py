#!/usr/bin/env python
#--*-- coding:utf-8 --*--

from greenlet import greenlet

def test1():
    print 12
    gr2.swith()
    print 34
    gr2.swith()

def test2():
    print 56
    gr1.swith()
    print 78
    gr1.swith()

gr1 = greenlet(test1)
gr2 = greenlet(test2)
gr1.swith()