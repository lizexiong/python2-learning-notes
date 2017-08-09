#!/usr/bin/env python
#--*-- coding:utf-8 --*--

import select
import time
import socket

ip_port = ('0.0.0.0',9999)
sk = socket.socket()
sk.bind(ip_port)
sk.listen(5)
sk.setblocking(False)

input = [sk,]
output = []
while True:
    rList, wList , error = select.select(input, output, [],1)
    for i in rList:
        if i == sk:
            conn, address = i.accept()
            input.append(conn)
        else:
            client_data = i.recv(1024)
            if client_data:
                output.append(i)

    for j in wList:
        j.sendall('天青色等烟雨')
        output.remove(j)
