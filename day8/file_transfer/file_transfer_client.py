#!/usr/bin/env python
#--*-- coding:utf-8 --*--

import socket,sys,os

ip_port = ('127.0.0.1',9999)

sk = socket.socket()

sk.connect(ip_port)

def renzheng():

    flag= True
    while flag:
        ulock = sk.recv(1024)
        if ulock == 'ulock':
            name = raw_input("请输入用户名：")
            sk.sendall(name)
            pwd = sk.recv(1024)
            passwd = raw_input("请输入密码")
            sk.sendall(passwd)
            succ = sk.recv(1024)
            if succ == 'succ':
                print "认证通过"
                flag = False
            else:
                print "错误，重新认证"
                continue
        else:
            print "账户被锁定"
            os._exit(0)
    print "开始传输文件..."
renzheng()







