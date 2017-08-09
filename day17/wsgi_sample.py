#!/usr/bin/env python
#coding:utf-8
from wsgiref.simple_server import make_server
import time
from jinja2 import Template

def qhc():
    data = open('html/qhc.html').read()
    current_time = str(time.time())
    # new_str = data.replace('@zexiong',current_time)
    template = Template(data)
    res = template.render(name='zexiong',age='24',current_time=current_time,
                          user_list=['wuxinzhe','lizexiong'],
						  num=1,
                          )
    return res.encode('utf-8')
	
def tygk():
    data = open('html/tygk.html').read()
    return data

url_list = [
    ('/qhc',qhc),
    ('/tygk',tygk)
]

def RunServer(environ, start_response):
    start_response('200 OK', [('Content-Type', 'text/html')])
    request_url = environ['PATH_INFO']
    print request_url
    # if request_url == '/qhc':
    #     return "天青色等烟雨"
    # elif request_url == '/tygk':
    #     return "风起燕南下"
    # else:
    #     return "404"
    # return '<h1>hello,web</h1>'
    for url in url_list:
        if request_url == url[0]:
            return url[1]()
    else:
        return "404"
 
if __name__ == '__main__':
    httpd = make_server('', 8001, RunServer)
    print("Serving HTTP on port 8001...")
    httpd.serve_forever()
