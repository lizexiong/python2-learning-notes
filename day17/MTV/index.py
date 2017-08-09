#!/usr/bin/env python
#coding:utf-8
from wsgiref.simple_server import make_server
import time
from jinja2 import Template
from url import url_list


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
