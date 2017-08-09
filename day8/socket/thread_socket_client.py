#!/usr/bin/env python
#--*-- coding:utf-8 --*--

import socket

# ip_port = ('127.0.0.1',9999)
#
# sk = socket.socket()
#
# sk.connect(ip_port)
# sk.settimeout(500)
#
# while True:
#     data = sk.recv(1024)
#     print "服务端返回：",data
#     l = raw_input("请输入值：")
#     sk.sendall(l)
#     if l == 'exit':
#         break
#
# sk.close()


#-------------------------------接收系统命令


ip_port = ('127.0.0.1',9999)

sk = socket.socket()
sk.connect(ip_port)
sk.settimeout(500)

while True:
    l = raw_input('请输入暗号:')
    sk.sendall(l)
    res_size = sk.recv(1024)
    print "服务器给我返回的：", res_size,type(res_size)
    sk.sendall("我准备开始接收了")
    total_size = int(res_size) #一共要收取的
    received_size = 0
    while True:
        data = sk.recv(1024)
        received_size += len(data)
        print total_size
        print received_size
        if total_size  == received_size:
            print '*******************************************************'
            print data
            break
        print '----------------------------------------------------------'
        print data
    if l == 'exit':
        break

sk.close()
