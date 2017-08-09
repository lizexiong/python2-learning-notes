#!/usr/bin/env python
#--*-- coding:utf-8 --*--

import sys
import select

while True:

    readable, wirteable, error = select.select([sys.stdin,],[],[],1)
    if sys.stdin in readable:
        print "sys.stdin 内容是", sys.stdin.readline()


import Threading

Threading.Read