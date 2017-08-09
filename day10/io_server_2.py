#!/usr/bin/env python
#--*-- coding:utf-8 --*--

import select
import socket
import time

ip_host = ('0.0.0.0',9999)
sk = socket.socket()
sk.bind(ip_host)
sk.listen(5)
sk.setblocking(False)

input = [sk,]
output = []
while True:
    rlist , w ,x = select.select(input, output , [] , 1)
    print "input的值",input
    # print "rlist的值",rlist
    time.sleep(2)
    # print w
    for i in rlist:
        if i == sk:
            conn, address = i.accept()
            input.append(conn)
            # output.append(conn)
            print address
        else:
            client_data = i.recv(1024)
            if client_data:
                i.sendall(client_data)
            else:
                input.remove(i)

