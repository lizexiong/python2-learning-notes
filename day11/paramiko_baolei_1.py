#!/usr/bin/env python
#--*-- coding:utf-8 --*--

import paramiko,select,os,sys,socket

tran = paramiko.Transport(('192.168.100.50',22))
tran.start_client()

#以下是使用密钥的方式，这里使用密码，但是密钥的方式还是贴出来。
"""
default_path只在linux里面有.
default_path = os.path.join(os.environ['HOME'],'.ssh','id_rsa')
key = paramiko.RSAKey.from_private_key_file(default_path)
tran.auth_publickey('root',key)
"""

#密码连接
tran.auth_password('root','huawei')

#打开一个通道
chan = tran.open_session()
#获取一个终端
chan.get_pty()
#激活
chan.invoke_shell()

#########
# 利用sys.stdin,肆意妄为执行操作
# 用户在终端输入内容，并将内容发送至远程服务器
# 远程服务器执行命令，并将结果返回
# 用户终端显示内容
#########

while True:
    #监视用户输入和服务器返回数据
    #sys.stdin处理用户输入
    #chan是之前创建的通道，用于接收服务器的返回信息
    readable, writeable, error = select.select([chan,sys.stdin,],[],[],1)
    if chan in readable:
        try:
            x = chan.recv(1024)
            if len(x) == 0:
                print '\r\n*** EOF\r\n',
                break
            #sys.stdout，一种输入方式
            sys.stdout.write(x)
            sys.stdout.flush()
            # print x   #print代替上面两行也是可以的，但是换行没控制好
        except socket.timeout:
            pass
    if sys.stdin in readable:
        inp = sys.stdin.readline()
        chan.sendall(inp)

chan.close()
tran.close()

