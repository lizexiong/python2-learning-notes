#!/usr/bin/env python
#--*-- coding:utf-8 --*--



import SocketServer


addr = ('127.0.0.1', 1234)
class MyTCPHandler (SocketServer.StreamRequestHandler):
        def handle (self):
                name_len = ord(self.rfile.read(1))
                print name_len
                name = self.rfile.read(name_len)
                print name
                print "Get request:%s"%name
                fd = open(name, 'w')
                cont = self.rfile.read(4096)
                while cont:
                        fd.write(cont)
                        cont = self.rfile.read(4096)
                fd.close()
                print "Out :%s"%name

server = SocketServer.TCPServer(addr, MyTCPHandler)
server.serve_forever()

