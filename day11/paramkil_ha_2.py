#!/usr/bin/env python
#--*-- coding:utf-8 --*--

import paramiko,uuid

class ha(object):

    def __init__(self):
        self.host = '192.168.100.50'
        self.port = 22
        self.user = 'root'
        self.pwd = 'huawei'

    def create_file(self):
        filename = str(uuid.uuid4())
        with open(filename,'w') as f:
            f.write('风起燕南下')
            f.close()
        return filename

    def connect(self):
        transport = paramiko.Transport((self.host,self.port))
        transport.connect(username=self.user,password=self.pwd)
        #将transport复制给私有字段self的transport，后面连接就可以调用了。
        self.__transport = transport

    def upload(self):
        file_name = self.create_file()

        #调用connection的私有字段
        sftp = paramiko.SFTPClient.from_transport(self.__transport)

        sftp.put(file_name,'/home/lizexiong.py')

    def rename(self):

        ssh = paramiko.SSHClient()
        ssh._transport = self.__transport


        stdin, stout, sterr = ssh.exec_command("mv /home/lizexiong.py /home/wuxinzhe.py")

        result = stout.read()
        ssh.close()

    def close(self):
        self.__transport.close()


    def run(self):
        self.connect()
        self.upload()
        self.rename()
        self.close()

obj = ha()
obj.run()
