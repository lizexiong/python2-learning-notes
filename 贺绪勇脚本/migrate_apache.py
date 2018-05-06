#-*- coding:UTF-8 -*-
# author:hexy
import os,urllib,json,platform,paramiko,psutil,shutil
from datetime import datetime

host_info = [{"ip":'xxx','port':'xxx',"username":'xxx','password':'xxx'},\
             {"ip":'xx','port':'xxx','username':'xxx','password':'xx'}
             ]

date_month = datetime.now().strftime('%Y-%m')
date_day = datetime.now().strftime('%Y-%m-%d')

#ssh连接
def ssh(host,port,user,passwd,order):
        # 创建SSH对象
        ssh = paramiko.SSHClient()
        # 允许连接不在know_hosts文件中的主机
        ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        # 连接服务器
        ssh.connect(hostname='%s' % host, port=port, username='%s' % user,password='%s' %passwd)
        # 加载环境变量
        ssh.exec_command('source /etc/profile')
        # 执行命令
        stdin, stdout, stderr = ssh.exec_command(order)
        # 获取命令结果
        result = stdout.read()
        # 关闭连接
        ssh.close()
        return result.decode()
#执行命令
def cmd(s):
    sys = platform.system()
    if sys == "Windows":
        print(s)
    elif sys == "Linux":
        print(s)
        os.system(s)

def cmd_p(s):
    sys = platform.system()
    if sys == "Windows":
        print(s)
    elif sys == "Linux":
        print(s)
        result = os.popen(s).read()
        return result

#安装oss客户端
def install_oss_client():
    for i in host_info:
        ip = i['ip']
        port = i['port']
        username = i['username']
        password = i['password']
        #判断是否已经安装了客户端
        result = ssh(ip,port,username,password,'rpm -qa ossfs')
        if not result:
            ssh = paramiko.SSHClient()
            ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
            ssh.connect(hostname='%s' % ip, port=22, username='%s' %username, password='%s' %password)
            ssh.exec_command('source /etc/profile')
            ssh.exec_command('wget -P /opt  http://docs-aliyun.cn-hangzhou.oss.aliyun-inc.com/assets/attach/32196/cn_zh/1507811607579/ossfs_1.80.3_centos6.5_x86_64.rpm?spm=5176.doc32196.2.7.kdXOYT&file=ossfs_1.80.3_centos6.5_x86_64.rpm')
            ssh.exec_command('echo blt-bak:LTAIuSYmLPC1JcSe:1y9nq7OOkxqyvOuGmn44zUjMCO3OR4 > /etc/passwd-ossfs')
            ssh.exec_command('chmod 640 /etc/passwd-ossfs')
            ssh.exec_command('mkdir -p  /ossfs/blt-bak/apache')
            ssh.exec_command('ossfs my-bucket /ossfs/blt-bak/apache -ourl=http://oss-cn-hangzhou.aliyuncs.com')

#拷贝和检测文件是否拷贝成功
def copy_log():
    for i in host_info:
        ip = i['ip']
        port = i['port']
        username = i['username']
        password = i['password']
        #获取主机名
        hostname = ssh(ip,port,username,password,'hostname')
        #创建文件夹
        ssh(ip,port,username,password,'mkdir -p /ossfs/blt-bak/apache/%s' %hostname)
        #获得要拷贝的文件夹列表
        month_str = ssh(ip,port,username,password,'ls /alidata/log/http')
        month_list = month_str.split('\n')
        for j in month_list:
            if j == '%s' %date_month:
                continue
            #该文件夹下的文件数量
            num_return = ssh(ip,port,username,password,'find /alidata/log/http/%s -type f|wc -l' %j)
            #该文件夹下的文件大小
            size_return = ssh(ip,port,username,password,'du -s /alidata/log/http/%s' %j).split()[0]
            #拷贝文件
            ssh(ip,port,username,password,'cp -a /alidata/log/http/%s /ossfs/blt-bak/apache/%s' %(j,hostname))
            #拷贝之后
            num_new_return = ssh(ip, port, username, password, 'find /ossfs/blt-bak/apache/%s/%s -type f|wc -l' %(hostname,j))
            size_new_return = ssh(ip, port, username, password, 'du -s /ossfs/blt-bak/apache/%s/%s' %(hostname,j)).split()[0]
            if num_return == num_new_return and size_return == size_new_return:
                #删除原先的日志文件夹
                ssh(ip,port,username,password,'rm -rf /alidata/log/http/%s' %j)
            else:
                print("拷贝失败,旧文件数量:%s  新文件数量:%s 旧文件夹大小:%s 新文件夹大小:%s" %(num_return,num_new_return,size_return,size_new_return))

if __name__ == '__main__':
    install_oss_client()
    copy_log()

