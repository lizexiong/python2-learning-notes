#!/usr/bin/env python
#coding:utf-8

#apt-get install sysstat

import commands

def monitor(frist_invoke=1):
    shell_command = 'sar 1 3| grep "^Average:"'
    #command执行命令，会得到两个值，一个为状态值，一个为命令执行返回的结果
    status,result = commands.getstatusoutput(shell_command)
    #如果状态码不等于0，那么就把状态记录到字典里面（状态码不为0表示出错）
    if status != 0:
        value_dic = {'status': status}
    #否则将得到的值分割之后并存入字典，然后返回
    else:
        value_dic = {}
        print('---res:',result)
        user,nice,system,iowait,steal,idle = result.split()[2:]
        value_dic= {
            'user': user,
            'nice': nice,
            'system': system,
            'idle': idle,
            'status': status
        }
    return value_dic

if __name__ == '__main__':
    print monitor()
