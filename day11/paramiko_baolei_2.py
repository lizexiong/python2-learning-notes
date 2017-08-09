#!/usr/bin/env python
#--*-- coding:utf-8 --*--

import select,sys,paramiko,termios,tty

tran = paramiko.Transport(('192.168.100.50',22))
tran.start_client()

tran.auth_password('root','huawei')

#打开一个通道
chan = tran.open_session()
#获取一个终端
chan.get_pty()
#激活
chan.invoke_shell()

#首先获取原tty属性，做好记录
oldtty = termios.tcgetattr(sys.stdin)


try:
    # 为tty设置新属性
    # 默认当前tty设备属性：
    #   输入一行回车，执行
    #   CTRL+C 进程退出，遇到特殊字符，特殊处理。

    # 这是为原始模式，不认识所有特殊符号
    # 放置特殊字符应用在当前终端，如此设置，将所有的用户输入均发送到远程服务器

    #这里fileno请百度和stdin的区别即可
    tty.setraw(sys.stdin.fileno())
    chan.settimeout(0.0)
    f = open('history.txt','a')
    while True:
        r, w, e = select.select([chan,sys.stdin,], [], [],1)
        if chan in r:
            try:
                x = chan.recv(1024)
                if len(x) == 0:
                    print 'end'
                    f.close()
                    break
                sys.stdout.write(x)
                sys.stdout.flush()
            except socket.timeout:
                pass

        if sys.stdin in r:
            #读取终端的一个字符
            x = sys.stdin.read(1)
            if len(x) ==0:
                break
            if x == '\t':
                pass
            else:
                f.write(x)
            chan.send(x)

#有finally关键字的时候,Python遇到错误在向你甩出错误之前还会留一口气先执行完finally里面的语句
finally:
    #重新设置终端属性
    termios.tcsetattr(sys.stdin,termios.TCSADRAIN,oldtty)

#这里一定要关闭，如果不正常关闭，就会抛异常
chan.close()
tran.close()
#以下代码是测试不关闭连接的报错后果，不关闭其实也不影响程序的运行
l= '**10'
print l