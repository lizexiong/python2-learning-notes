#!/usr/bin/env python
#--*-- coding:utf-8 --*--
from socket import *
import os.path
import sys
target = ('127.0.0.1',1234)
def get_header (name):
        leng = len(name)
        assert leng < 250
        return chr(leng) + name

def send_file (name):
        basename = os.path.basename(name)
        header = get_header(basename)
        cont = open(name).read()
        s = socket (AF_INET, SOCK_STREAM)
        s.connect(target)
        s.sendall (header)
        s.sendall (cont)
        s.close()

# for i in sys.argv[1:]:
#
#         print i
#         send_file (i)


send_file('c:\\ipop\index.html')
