#!/usr/bin/env python
#--*-- coding:utf-8 --*--

import paramiko,uuid

class ha(object):

    def __init__(self):
        self.host = '192.168.100.50'
        self.port = 22
        self.user = 'root'
        self.passwd = 'huawei'

    def create_file(self):
        filename = str(uuid.uuid4())
        with open(filename,'w') as f:
            f.write('天青色等烟雨')
        return filename

    def upload(self):
        file_name = self.create_file()

        transport = paramiko.Transport((self.host,self.port))
        transport.connect(username=self.user,password=self.passwd)
        #这里使用的是上句封装的transport
        sftp = paramiko.SFTPClient.from_transport(transport)
        sftp.put(file_name,'/root/lizexiong.py')
        transport.close()

    def rename(self):
        ssh = paramiko.SSHClient()

        ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        ssh.connect(hostname=self.host,port=self.port,username=self.user,password=self.passwd)

        stdin, stout, sterr = ssh.exec_command("mv /root/lizexiong.py /root/wuxinzhe.py")

        result = stout.read()

        ssh.close()

    def run(self):
        self.upload()
        self.rename()

obj = ha()
obj.run()

