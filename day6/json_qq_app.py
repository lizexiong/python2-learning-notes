#!/usr/bin/env python
#-*- coding:utf-8 -*-

import json

f= file('data_to_qq.txt','rb')
name = json.loads(f.read())
f.close()
print name['lizexiong']

name_type=type('name')
print name_type