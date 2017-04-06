#!/usr/bin/env python
#--*-- coding:utf8 --*--

def func(arg):
    seed = 0
    while True:
        seed += 1
        if seed > 10:
            return
        else:
            yield seed


for i in func(10):
    print i