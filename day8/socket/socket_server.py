#!/usr/bin/env python
#--*-- coding:utf-8 --*--

import socket

# ip_port = ('127.0.0.1',9999)
#
# sk = socket.socket()
# sk.bind(ip_port)
# sk.listen(5)
#
# while True:
#     print "Server Waiting...."
#     conn,addr = sk.accept()
#     print conn,addr
#
#     client_data = conn.recv(102400)
#     print client_data
#     conn.sendall('而我在等你')
#     conn.close()

ip_port = ('127.0.0.1',9999)
sk = socket.socket()
sk.bind(ip_port)
sk.listen(5)


while True :
    print "等待输入...."
    conn,addr = sk.accept()
    conn.sendall('为了不让客户端阻断')
    Flag = True
    while Flag:
        client_data = conn.recv(1024)
        print client_data
        if client_data == 'exit':
            break
        elif client_data == '0':
            conn.sendall("天青色等烟雨，而我在等你")
        else :
            conn.sendall("风起燕南下，景潇潇落黄沙")
    conn.close()


##################################第二种逻辑方式，失败，失败原因笔记里面记录

#
# ip_port = ('127.0.0.1',9999)
# sk = socket.socket()
# sk.bind(ip_port)
# sk.listen(5)
#
# while True :
#     print "等待输入...."
#     conn,addr = sk.accept()
#     # conn.sendall('为了不让客户端阻断')
#     print conn
#     Flag = True
#     client_data = conn.recv(1024)
#     print client_data
#     if client_data == 'exit':
#         break
#     elif client_data == '0':
#         conn.sendall("天青色等烟雨，而我在等你")
#     else :
#         conn.sendall("风起燕南下，景潇潇落黄沙")
# conn.close()