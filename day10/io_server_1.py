#!/usr/bin/env python
#--*-- coding:utf-8 --*--

import socket
import time
import select


ip_port = ('0.0.0.0',9998)
sk = socket.socket()
sk.bind(ip_port)
sk.listen(5)
sk.setblocking(False)

ip_port = ('0.0.0.0',9999)
sk1 = socket.socket()
sk1.bind(ip_port)
sk1.listen(5)
sk1.setblocking(False)

# while True:
#     try:
#         conn,address = sk.accept()
#         print conn,"这里个人理解为句柄的内存地址"
#         print address,"客户端的信息"
#         conn.close()
#     except Exception,e:
#         print e
#         time.sleep(2)

while True:
    r,w,x = select.select([sk,sk1],[],[],1)
    for i in r:
        conn,address = i.accept()
        print address
