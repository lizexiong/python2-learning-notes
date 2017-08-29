#!/usr/bin/env python
# -*- coding:utf-8 -*-

import tornado.ioloop
import tornado.web
from tornado.escape import linkify
import uimodules as md
import uimethods as mt

class MainHandler(tornado.web.RequestHandler):
    def get(self):
        self.render('login.html')

settings = {
    'template_path': 'template',
    'static_path': 'static',
    'static_url_prefix': '/static/',
    #这里就是导入到配置文件里面，然后把配置文件传给application就可以使用了
    'ui_methods': mt,
    'ui_modules': md,
}

application = tornado.web.Application([
    (r"/index", MainHandler),
], **settings)


if __name__ == "__main__":
    application.listen(8009)
    tornado.ioloop.IOLoop.instance().start()