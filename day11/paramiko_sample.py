#!/usr/bin/env python
#--*-- coding:utf-8 --*--

# import paramiko
#
# # 创建SSH对象
# ssh = paramiko.SSHClient()
# # 允许连接不在know_hosts文件中的主机
# ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
# # 连接服务器
# ssh.connect(hostname='10.2.129.36',port=22,username='root',password='dell123@')
#
# #执行命令
# stdin, stout, sterr = ssh.exec_command('hostname')
#
# result = stout.read()
# print result
#
# ssh.close

import paramiko

tranport = paramiko.Transport(('10.2.129.36',22))
tranport.connect(username='root',password='dell123@')

ssh = paramiko.SSHClient()
ssh._transport = tranport

stdin, stout, sterr = ssh.exec_command('hostname')
result = stout.read()
print result

tranport.close()