#!/usr/bin/env python
#--*-- coding:utf-8 --*--

class F1:
    pass

class S1(F1):
    def show(self):
        print "S1.SHOW"

class S2(F1):
    def show(self):
        print "S2.SHOW"

def func(obj):
    print obj.show()



s2_obj = S2()
func(s2_obj)

s2_obj.show()

