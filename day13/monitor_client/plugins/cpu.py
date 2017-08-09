#!/usr/bin/evn python
#--*-- coding:utf-8 --*--

import commands

def monitor():
    shell_command = 'sar 1 3 | grep "^Average"'
    status, result = commands.getstatusoutput(shell_command)
    if status != 0:
        value_dic = {
            'status' : status
        }
    else:
        user, nice, system, iowait, steal, idle = result.split()[2:]
        value_dic = {
            'status' : status,
            'user': user,
            'nice': nice,
            'system': system,
            'iowait': iowait,
            'steal': steal,
            'idle' : idle
        }
    return value_dic
