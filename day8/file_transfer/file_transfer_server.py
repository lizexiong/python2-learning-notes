#!/usr/bin/env python
#--*-- coding:utf-8 --*--

import struct,SocketServer,sys,os

class MyServer(SocketServer.BaseRequestHandler):
    userinfo = {'name' : 'lizexiong','pwd': 'huawei'}



    def handle(self):
        print "客户端信息",self.client_address

        count = 0
        if count < 3:
            flag = True
            while flag and count <3:
                self .request.sendall('ulock')
                name = self.request.recv(1024)
                self.request.sendall('pwd')
                passwd = self.request.recv(1024)

                if name == MyServer.userinfo['name'] and passwd == MyServer.userinfo['pwd']:
                    print "认证成功"
                    self.request.sendall('succ')
                    flag = False
                    break
                else:
                    self.request.sendall("fail")
                    count += 1
                    print count
                    continue
        else:
            self.request.sendall('lock')


        if count >= 3 :
            exit()

        print "开始传输数据"



if __name__ == '__main__':
    server = SocketServer.ThreadingTCPServer(('127.0.0.1',9999),MyServer)
    server.serve_forever()
