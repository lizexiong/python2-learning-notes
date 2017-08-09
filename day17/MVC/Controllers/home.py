#!/usr/bin/env python
#coding:utf-8


from wsgiref.simple_server import make_server
import time
from jinja2 import Template



def qhc():
    data = open('Views/qhc.html').read()
    current_time = str(time.time())
    # new_str = data.replace('@zexiong',current_time)
    template = Template(data)
    res = template.render(name='zexiong',age='24',current_time=current_time,
                          user_list=['wuxinzhe','lizexiong'],
						  num=1,
                          )
    return res.encode('utf-8')
	
def tygk():
    data = open('Views/tygk.html').read()
    return dataViews