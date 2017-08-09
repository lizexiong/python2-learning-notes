#!/usr/bin/env python
#--*-- coding:utf-8 --*--

# import userinfo

from wsgiref.simple_server import make_server

def RunServer(environ, start_response):
    start_response('200 OK', [('Content-Type', 'text/html')])
    url = environ['PATH_INFO']
#这里使用直接找出下标的值
    # controller,action = raw_input("请输入URL:").split('/')
    controller = url.split('/')[1]
    action = url.split('/')[2]
    module = __import__(controller)
    is_exist = hasattr(module, action)
    if is_exist:
        func = getattr(module, action)
        ret = func()
        return ret
    else:
        return '404 not found'

if __name__ == '__main__':
    httpd = make_server('', 8000, RunServer)
    print "Serving HTTP on port 8000..."
    httpd.serve_forever()