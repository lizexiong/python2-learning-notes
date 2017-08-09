#!/usr/bin/env python
#--*-- coding:utf-8 --*--


import paramiko,json,threading

class remote_host(object):

    def __init__(self,host,port,user,pwd,cmd):
        self.host = host
        self.port = port
        self.user = user
        self.pwd = pwd
        self.cmd = cmd

    def command(self):
        ssh = paramiko.SSHClient()
        ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())   # 允许连接不在know_hosts文件中的主机
        ssh.connection(hostname=self.host,port=self.port,user=self.user,password=self.passwd)
        stdin, stdout, stderr = ssh.exec_command(self.cmd)
        ret, err = stdin.read(),sterr.read()
        result = res if res else err
        print ("[%s]".center(50,"-")%self.host)
        print result.decode()
        ssh.close()

    def put(self):
        try:
            transport = paramiko.Transport((self.host,self.port))
            transport.connect(username=self.user,password=self.pwd)
            sftp = paramiko.SFTPClient.from_transport(transport)
            sftp.put(self.cmd.split()[1],self.cmd.split()[2])
            transport.close()
            print ("\033[32;0m[%s]upload [%s]successful...\033[0m"%(self.host,self.cmd.split()[2]))
        except Exception as error:
            print ("\033[31:0m %s %s error\033[0m"%(self.host,error))

    # def run(self):
    #     cmd_str = self.cmd.split()[0]
    #     if hasattr(self,cmd_str):
    #         getattr(self,cmd_str)()
    #     else:
    #         setattr(self,cmd_str,self.cmd)
    #         getattr(self,cmd_str)()

    def run(self):
        #反射
        cmd_str = self.cmd.split()[0]
        if hasattr(self,cmd_str):
            getattr(self,cmd_str)()
        else:
            setattr(self,cmd_str,self.command)
            getattr(self,cmd_str)()

if __name__ == "__main__":
    with open('database','r') as file:
        data_dict = json.loads(file.read())
    for k in data_dict:
        print k

    group_choice = raw_input("Please group name..").strip()
    if data_dict.get(group_choice):
        host_dict = data_dict[group_choice]
        for j in host_dict:
            print j
        while True:
            cmd = raw_input("Input your cmd...").strip()
            thread_list=[]
            if cmd:
                for k in host_dict:
                    host, port ,username, password = k,host_dict[k]["port"],host_dict[k]["username"],host_dict[k]["password"]
                    func = remote_host(host,port,username,password,cmd)
                    t = threading.Thread(target=func.run)
                    t.start()
                    thread_list.append(t)
                # for t in thread_list:
                #     t.join()
    else:
        print "\033[31;0m group is not \033[0m"



