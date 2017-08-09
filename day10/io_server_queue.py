#!/usr/bin/env python
#--*-- coding:utf-8 --*--


import select
import time
import socket
import Queue

ip_port = ('0.0.0.0',9999)
sk = socket.socket()
sk.bind(ip_port)
sk.listen(5)
sk.setblocking(False)

input = [sk,]
output = []
message = {}
while True:
    rList, wList , error = select.select(input, output, [],1)
    for i in rList:
        if i == sk:
            conn, address = i.accept()
            input.append(conn)
            message[conn] = Queue.Queue()
        else:
            client_data = i.recv(1024)
            if client_data:
                output.append(i)
                #在指定队列插入数据
                message[i].put(client_data)
            # else:
            #     input.remove(i)

    for j in wList:
        #去指定队列取数据
        try:
            data = message[j].get_nowait()
        except Queue.Empty:
            pass
        j.sendall(data)
        output.remove(j)
        #队列数据处理完成后没有必要存在了
        # del message[j]
