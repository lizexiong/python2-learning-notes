#!/usr/bin/env python
#--*-- coding:utf-8 --*--

import sys
import socket_server
from conf import settings
class ArgvHandler(object):
    def __init__(self,args):
        self.args = args
        # print self.args
        self.argv_parser()
    def argv_parser(self):
        if len(self.args) == 1:
            print self.args
            self.help_msg()
        else:
            #这里的self就是自己argvHandler类，窒息想想类的调用关系
            if hasattr(self,self.args[1]):
                func = getattr(self,self.args[1])
                #func()解析出来就是用户输入的参数，如start，stop等
                func()
            else:
                print self.args
                self.help_msg()

    def help_msg(self):
        msg = '''
        start   :start ftp server
        stop    :stop ftp server
        '''
        print (msg)

    def start(self):
    #这里写成了专门调用配置文件的方法
        server = socket_server.SocketServer.ThreadingTCPServer((settings.BIND_HOST,settings.BIND_PORT),socket_server.FtpServer)
        server.serve_forever()

