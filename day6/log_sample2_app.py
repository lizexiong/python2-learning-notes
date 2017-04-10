#!/usr/bin/env python
#--*-- coding:utf-8 --*--

import log_sample2

num=0
while 1:
    test = raw_input("请输入数字 \n ")

    if test.isdigit():
        print test
        log_sample2.logger.debug(test)
    else:
        print test
        log_sample2.logger.debug(test)
        num+=1
        print num
        if num>3:
            break
