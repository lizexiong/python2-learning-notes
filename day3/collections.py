#!/usr/bin/env python
#--*-- coding:utf-8 --*--

# obj = open('test.txt','r')
# print obj.tell()
# obj.seek(5)
# li = obj.read()
# print li
# print obj.tell()
# obj.close()


# obj = open('test.txt','r+')
# print obj.read()
# obj.seek(5)
# obj.write('\nliuwen')
# obj.close()

# obj = open('test.txt','r+U')
# print obj.readlines()
#
# obj.close()


with open('test.txt','r') as obj1,open('test1.txt','w') as obj2:
    for line in obj1:
        new_line = line.replace('test','烟花易冷')
        obj2.write(new_line)

