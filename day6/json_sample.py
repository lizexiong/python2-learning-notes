#!/usr/bin/env python
#-*- coding:utf-8 -*-
import json
# import datetime
# name = {
#     'lizexiong': datetime.datetime.now(),
#     'wuxinzhe' : [34,"erwozaidengni"],
# }
#
# f = file('data_to_qq.txt','w')
# json_name = json.dumps(name)
# f.write(json_name)

#######dumps与dump区别演示
#######dump######
a=range(10)
to_qq = file('data_to_qq.txt','w')
json.dump(a,to_qq)