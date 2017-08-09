#!/usr/bin/env python
#--*-- coding:utf-8 --*--

import socket,sys,paramiko

tran = paramiko.Transport(('192.168.100.50',22))
tran.start_client()

tran.auth_password(username='root',password='huawei')

#打开一个通道
chan = tran.open_session()

#获取一个终端
chan.get_pty()

#激活
chan.invoke_shell()

def windows_shell():
    import threading

    sys.stdout.write("Line-buffered terminal emulation. Press F6 or ^Z to send EOF.\r\n\r\n")

    def writeall(sock):
        while True:
            data = sock.recv(256)
            print chan
            if not data:
                print "end"
                break
            sys.stdout.write(data)
            sys.stdout.flush()

    write = threading.Thread(target=writeall,args=(chan,))
    write.start()

    try:
        while True:
            d = sys.stdin.read(1)
            if not d:
                break
            chan.send(d)
    except EOFError:
        pass

i = windows_shell()
i
chan.close()
tran.close()

