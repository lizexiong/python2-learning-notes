#!/usr/bin/env python
#--*-- coding:utf-8 --*--

import socket

def handle_request(client):
    buf = client.recv(1024)
    print buf
    #这里可以理解为一种固定格式，因为要将浏览器请求识别通过以下特殊方法
    client.send("HTTP/1.1 200 OK\r\n\r\n")
    client.send("Hello, World")

def main():
    #首先执行的是这里的函数，创建一个socket对象
    sock = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
    #监听的地址和端口
    sock.bind(('localhost',80))
    #开始监听，以及最大连接数
    sock.listen(5)

    while True:
        print "开始监听..."
    #这里开始阻塞，一直等待，等待到有请求过来
        connection,address = sock.accept()
    #connection，代表客户端sokcet对象，address，客户端IP地址以及端口号
        print connection
        print address
    #然后执行handle_request函数
        handle_request(connection)
        connection.close()

if __name__ == '__main__':
    main()

