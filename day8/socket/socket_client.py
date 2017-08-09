#!/usr/bin/env python
#--*-- coding:utf-8 --*--

import socket

# ip_port = ('127.0.0.1',9999)
#
# sk = socket.socket()
#
# sk.connect(ip_port)
#
# sk.sendall('天青色等烟雨')
#
# server_reply = sk.recv(102400)
# print server_reply
#
# sk.close()

ip_port = ('127.0.0.1',9999)

sk = socket.socket()

sk.connect(ip_port)
sk.settimeout(500)

while True:
    data = sk.recv(1024)
    print "服务端返回：",data
    l = raw_input("请输入值：")
    sk.sendall(l)
    if l == 'exit':
        break

sk.close()


##################################第二种逻辑方式，失败，失败原因笔记里面记录
# ip_port = ('127.0.0.1', 9999)
#
# sk = socket.socket()
#
# sk.connect(ip_port)
# sk.settimeout(500)
#
# while True:
#
#     l = raw_input("请输入值：")
#     sk.sendall(l)
#     data = sk.recv(1024)
#     print "服务端返回：",data
#     if l == 'exit':
#         break
#
# sk.close()