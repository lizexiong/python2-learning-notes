#!/usr/bin/env python
#--*-- coding:utf-8 --*--

import os,sys

msg = """
\033[42;1mWelcome to Python\033[0m
"""
print msg

host_dic = {
    'itsm' : '192.168.100.50'
}

while True:
    for hostname,ip in host_dic.items():
        print hostname,ip
    try:
        host = raw_input("Please input your host:").strip()
        if host == 'quit':
            print "Bye"
            break
    except KeyboardInterrupt: sys.exit(0)
    except EOFError:sys.exit(0)
    if len(host) == 0:continue
    if not host_dic.has_key(host):
        print "Not host"
        continue
    print '\033[32;1m Connect to ... \033[0m',host_dic[host]
    os.system("python demo.py %s" %host_dic[host])

