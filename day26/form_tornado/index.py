#!/usr/bin/env python
# -*- coding:utf-8 -*-
  
import tornado.ioloop
import tornado.web
from hashlib import sha1
import os, time
import re

class IPField(object):
    REGULAR = "^(25[0-5]|2[0-4]\d|[0-1]?\d?\d)(\.(25[0-5]|2[0-4]\d|[0-1]?\d?\d)){3}$"
    def __init__(self,error_msg_dict=None, required=True):
        error_msg = {}
        if error_msg_dict:
            error_msg.update(error_msg_dict)

        #把这两个字段封装到IpField类里面
        self.required = required
        self.error_msg = error_msg

    def check_valid(self,request,k):
        flag = True
        import re
        if self.required:
            if not request.get_argument(k):
                flag =False
                print self.error_msg['required']
            else:
                if re.match(self.REGULAR,request.get_argument(k)):
                    pass
                else:
                    flag =False
                    print self.error_msg['valid']
        else:
            pass
        return flag

class BaseForm(object):
        #2.__这里的self就是把自己MainForm传入进入，就是self，但是还有一个self（MainHandler）怎么办，那么他就是request
    #就是这里的self=MainForm   request=MainHandler
    def is_valid(self,request):
        flag = True
        print self.__dict__,'BaseForm'
        for v in self.__dict__.values():
            print v,'BaseForm------'
        for k,v in self.__dict__.items():
            #这是v就是一个对象了
            ret = v.check_valid(request,k)
            print ret,'ret---'
            if not ret:
                flag = False
        return flag

class MainForm(BaseForm):
    def __init__(self):
        # self.host = "(.*)"
        # self.ip = "^(25[0-5]|2[0-4]\d|[0-1]?\d?\d)(\.(25[0-5]|2[0-4]\d|[0-1]?\d?\d)){3}$"
        # self.port = '(\d+)'
        # self.phone = '^1[3|4|5|8][0-9]\d{8}$'
        #对象里面封装了正则表达式和错误信息
        self.ip =  IPField(error_msg_dict={'required':"IP不能为空",'valid':'IP格式错误'},required=True)
        print self.__dict__,'MainForm'

class MainHandler(tornado.web.RequestHandler):
    def get(self):
        self.render('index.html')
    def post(self, *args, **kwargs):
        flag = True
        print IPField.__dict__,'IPFIELD'
        obj = MainForm()
        #1__这里要注意，我要传入把当前对象传入进去，那么就是MainHandler就是self，自己传入进去，然后
        obj.is_valid(self)

        if obj.is_valid(self):
            self.write('ok')
        else:
            self.write('error')

settings = {
    'template_path': 'template',
    'static_path': 'static',
    'static_url_prefix': '/static/',
    'cookie_secret': 'aiuasdhflashjdfoiuashdfiuh',
    'login_url': '/login'
}
  
application = tornado.web.Application([
    (r"/index", MainHandler),
], **settings)

if __name__ == "__main__":
    application.listen(8888)
    tornado.ioloop.IOLoop.instance().start()