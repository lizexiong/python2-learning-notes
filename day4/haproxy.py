#!/usr/bin/env python
#--*-- coding:utf8 --*--

"""
本代码演示一个备份文件怎么添加，删除，以及查询
本章使用的重点
1.标志位
2.字符串拼接
3.if for if 嵌套
"""

import json
import os


#这里的代码主要做查找的功能
def fetch(backend):
    fetch_list = []
    with open ('ha','r') as obj1:
#这里主要是一个标志位的使用
        flag = False
        for line in obj1:
#第一个判断条件，当循环的字符串去掉空行等于定义的变量时
            if line.strip() == "backend %s" % backend:
#那么就把标志位设置为True，并且跳出本次循环，进行下一次循环，且下一次循环肯定是我们要的值。
                flag = True
               # print "test contiue"
                continue
#这是，标志位为真，并且line的开头为backend，那么就结束掉本次循环
            if  flag and line.strip().startswith('backend'):
                #print "test breck"
                break
#只有当输入的backend等于我们定义的值的时候，flag才位真，所以，这里循环的把值追加到列表里面的，肯定w.h.c下面的数据
            if flag and line.strip():
                fetch_list.append(line.strip())
    return fetch_list


# result = fetch("www.huawei.com")
# print result

def add1(dict_info):
#现在来个初始化，声明几个变量。
#获取字典里s ,backend的值
    backend_title = dict_info.get('backend')   #对比条件1， 取出需要加入值的backend
#对比条件2，当前值为数据主体部分，拼接的
    crrent_record = "server %s %s weight %d maxconn %d" %(dict_info['record']['server'],dict_info['record']['server'],dict_info['record']['weight'],dict_info['record']['maxconn'])
# 1.获取指定backend下的所有记录。
    fetch_list = fetch(backend_title)                   #对比条件3，指定backend下的所有主题配置文件
#这里用not是因为如果fetch_list是空列表，那么返回值就是False
    crrent_title = "backend %s" % backend_title     #增加条件，增加要输入的域名

  #  print fetch_list

#如果backend主体里面没有数据，那么开始最大的树判断
    if  fetch_list:
#如果主体记录在 配置文件主体里面有，那么就跳过
        if crrent_record in fetch_list:
            pass
        else:
#把值把值追加进fetch_list列表
            fetch_list.append(crrent_record)
#定义两个标志位
            flag = False
            has_write = False

            with open('ha') as obj1,open('ha1','w') as obj2:
                for i in obj1:
                    if i.strip() == 'backend %s' % backend_title:
                        flag=True
                        obj2.write(i)  #把backend写入到新配置文件里面
                        continue
                    if flag and i.strip().startswith('backend'):
                     #这里设置为flase就是为了写一些其它的backend记录
                        flag = False
                    if flag and i.strip():
                        #把已经追加处理完的主体文件写到新的配置中
                        if not has_write:
                             for j in fetch_list:
                                temp = "%s%s\n" %(" "*8,j)
                                obj2.write(temp)
                                has_write = True
                    #否则为false的时候，那么就其它记录写入
                    else:
                        obj2.write(i)
                  #  obj2.write(i)
#否则，如果没有人任何值存在，那么全部新建
    else:
        #pass #不存在backend，添加backend和记录
        with open('ha') as obj1,open('ha1','w') as obj2:
            for line in obj1:
                obj2.write(line)
            obj2.write("\n"+ crrent_title+ "\n")
#以下方式只能使用字符拼接，这里有2个占位符是因为第一个占位符是8个空格的。
            temp="%s%s\n" %(" " * 8, crrent_record )
            obj2.write(temp)

#josn里面的值一定要是双引号，不能是单引号
# s = '{"backend": "fuck.huawei.com","record":{"server": "100.1.7.29","weight": 20,"maxconn": 3000}}'
# #用json把字符串变成字典
# data_dict=json.loads(s)
#
# add1(data_dict)





#由于还没有学会删除的方法，这里直接使用continue来跳出方法删除。

def del1(del_info):
#首先还是要取出需要对比的值
    backend_title = del_info.get('backend') #获取字典的的域名，也是人要输入域名
    fetch_list = fetch(backend_title)  #配置文件backend下主体内容
    cur_list = "backend %s" % backend_title #backup +域名需要匹配的值
    crrent_record = "server %s %s weight %d maxconn %d" %(del_info['record']['server'],del_info['record']['server'],del_info['record']['weight'],del_info['record']['maxconn'])
#    print fetch_list


#判断fetch_list主体文件是否存在，如果存在，那么才开始。
    if fetch_list:
        with open ('ha') as obj1,open('ha1','w') as obj2:
            flag = False
            #fetch_list.append(crrent_record)
            has=False
#本章实现的主要是思路问题，一般有那几种情况，哪几种情况下有哪几种情况，和增加类似，
#但是不同的是，这里的删除是找到这个值以后直接continue的方式不在记录来删除
            for line in obj1:
                if crrent_record in fetch_list:
                    if line.strip() == cur_list:
                        obj2.write(line)
                        flag=True
                        print "1"
                        continue
                    if line.strip().startswith('backend'):
                        flag=False
                        print "2"
                    if flag:
                        print "4"
                        if not has:
                            for j in fetch_list:
                                print "5"
                                if j == crrent_record:
                                    print 6
                                    continue
                                else:
                                    temp1 = "%s%s\n" %(" "*8,j)
                                    obj2.write(temp1)
#如，这里的for本来要循环3次，但是在外圈限制了has为Flase的时候才能循环，所以，每次写完数据后这里的if就停止了，进行下一次
#更改的外圈循环才会在来执行。
                                    has = True

                    else:
                        obj2.write(line)
                else:
                    return
                   # obj2.write(line)
    else:
        return

#del1(data_dict)
if __name__ == '__main__':

    print "1.获取；2.添加 3.删除"
    num = raw_input("请输入序号")
    data = raw_input("请输入内容:")
    if num == "1":
#        fetch(data)
        result = fetch(data)
        print result
    else:
        dict_data = json.loads(data)
        if num == "2":
            add1(dict_data)
        elif num == '3':
            del1(dict_data)
        else:
            pass

