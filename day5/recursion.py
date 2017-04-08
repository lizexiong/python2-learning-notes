#!/usr/bin/env python
#--*-- coding:utf-8 --*--

def func(a,b,times):
    times +=1
    if a == 0:
      pass
    c = a + b
    if c > 50000:
        return c
    ret = func (b,c,times)
    print ret,times

l=func(0,1,0)
print l

