#/usr/bin/env python
#--*-- coding:utf-8 --*--

import os
ls = os.linesep

fname = 'test.txt'
flag=True
while flag:

    if os.path.exists(fname):
        print "Error:'%s' already exists" % fname
        exit()
    else:
        break

all = []
print "\n Enter lines('.' by itself to quit).\n"

while True:
    entry = raw_input('>')
    if entry == '.':
        break
    else:
        all.append(entry)

obj = open(fname, 'w+')
obj.writelines(['%s%s' %(x,ls) for x in all])
obj.close