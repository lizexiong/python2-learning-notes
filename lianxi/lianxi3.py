#!/usr/bin/env python
#--*-- coding:utf-8 --*--

a = raw_input("Num1")
b = raw_input('Num2')
c = raw_input('Num3')
d = raw_input('Num4')
e = raw_input('Num5')

aa = [a,b,c,d,e]


def input():
    z = raw_input("请输入你要需要的功能,\n \
              (1)取5个数的和 \n\
              (2)取5个数的平均值 \n  \
                (3)退出输入x   \n \
              ")
    flag = True
    while flag:
        if z == '1':
            return '1'
            flag = False
        elif z == '2':
            return '2'
            flag = False
        elif z == 'x':
            break
        else:
            continue


def he():
    j = 0
    for i in aa:
        j += int(i)
    return j

def p():
    j = 0
    for i in aa:
        j += int(i)
    g = j / len(aa)
    return g

def main():
    l = input()
    if l == '1':
        h =he()
        return h
    elif l == '2':
        pingju = p()
        print pingju
        return pingju


zx = main()

__name__



# i=0
# j=0
# while i< len(aa):
#     # print aa[i],i
#     j=j+int(aa[i])
#     i+=1
# print j
# j=0
# for i in aa:
#    j += float(i)
# z = float(j) / len(aa)
# print z


# while True:
#     i = raw_input("Please Input num")
#     if int(i) < 100 and int(i)>0:
#         print i
#         break
#     else:
#         print "else"
#         continue
