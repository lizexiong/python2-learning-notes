#!/usr/bin/env python
#--*-- coding:utf-8 --*--

import SocketServer
import os

# class MyServer(SocketServer.BaseRequestHandler):
#
#     def handle(self):
#         # print self.request,self.client_address,self.server父类方法里就有
#         conn = self.request
#         print "是谁连接过来...", self.client_address
#         conn.sendall('天青色等烟雨...')
#         Flag =True
#         while Flag:
#             data = conn.recv(1024)
#             if data == 'exit':
#                 Flag = False
#             else:
#                 print data
#                 conn.sendall(data)
#
# if __name__ == '__main__':
#     server = SocketServer.ThreadingTCPServer(('127.0.0.1',9999),MyServer)
#     server.serve_forever()



#-------------------------接收系统命令----------------------

class MyServer(SocketServer.BaseRequestHandler):

    def handle(self):
        conn = self.request
        print "是谁连接过来了...", self.client_address
        # conn.sendall("谁在用琵琶弹奏一曲东风破")
        flag = True
        while flag:
            data = self.request.recv(1024)
            data= data.strip()
            res_cmd = os.popen(data).read()
            print "客户端的长度：",len(res_cmd)
            self.request.send(str(len(res_cmd)))
            c = self.request.recv(1024)
            print c
            self.request.sendall(res_cmd)
            if data == 'exit':
                break

if __name__ == '__main__':
    server = SocketServer.ThreadingTCPServer(('127.0.0.1',9999),MyServer)
    server.serve_forever()

