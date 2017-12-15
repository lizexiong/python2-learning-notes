# -*- coding: utf-8 -*-
import tornado.httpserver
import tornado.ioloop
import tornado.web
from tornado.options import define, options, parse_command_line

import sys
from applications import application,PORT


def start_application():
    #加载环境配置项
    define('port',default=PORT,type=int,help=u"run on the port")
    parse_command_line()
    print ('serve listen port %s' % options.port)

    application.listen(options.port,address="0.0.0.0")

    tornado.ioloop.IOLoop.instance().start()

if __name__ == "__main__":
    start_application()


