#!/usr/bin/env python
#--*-- coding:utf-8 --*--

import random
checkcode = ''
#定义循环4次
for i in range(4):
    #定义每次随机的数在0-3之间，一共4个数的意思，不是0-4的意思
    current = random.randrange(0,4)
    if i != current:
        #如果每次循环的数不等于随机的数，那么temp等于65-90对应的数里面转换的字母
        temp = chr(random.randint(65,90))
        #否则，就等于数字
    else:
        temp = random.randint(0,9)
    checkcode += str(temp)
print checkcode