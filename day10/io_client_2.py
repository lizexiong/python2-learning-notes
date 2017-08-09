#!/usr/bin/env python
#--*-- coding:utf-8 --*--

import socket

ip_port = ('127.0.0.1',9999)
sk = socket.socket()
sk.connect(ip_port)
sk.settimeout(5)


while True:
    i  = raw_input("请输入")
    sk.sendall(i)
    print sk.recv(1024)

sk.close