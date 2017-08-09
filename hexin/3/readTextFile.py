#/usr/bin/env python
#--*-- coding:utf-8 --*--

fname = raw_input('请输入你的文件名：')

print

try:
    obj = open(fname,'r')
except IOError, e:
    print "Error:",e
else:
    for i in obj:
        print i,
    obj.close()