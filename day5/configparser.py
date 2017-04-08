#!/usr/bin/env python
#--*-- coding:utf8 --*--

import ConfigParser
config = ConfigParser.ConfigParser()
config.read("configparsertest")



#############读取[]#########
#这里读出的中[]号里的内容，固定格式
print "======读取文件分隔符======"
r=config.sections()
print r
print "***读取指定[]下的key***"
rr=config.options('huawei')
print rr
print   "***读出所有item***"
items_list = config.items('huawei')
print items_list
print   "***读取指定[]key的值***"
var = config.get('huawei','k1')
print var
print "***读取值后强制转换数据类型***"
var1 = config.getint('huawei','k2')
#这里原始数据显示是数字，其实是字符串，要进过一次转换
print var1

#############改写#############
print "***删除一个组下的值***"
sec = config.remove_section('huawei')
print sec
#这里会返回一个布尔类型，但是文件并没有改变，因为只是把
#内存里的值删除了，如果文件要修改，要将内存里面的值写入内存
#config.write(open('configparsertest','w'))

print "***查找有没有这个组***"
sec1 = config.has_section('huawei2')
print sec1
print "***添加一个组***"
config.add_section('huawei3')
config.write(open('configparsertest','w'))
#这里如果不写入文件是看不出来效果的，因为，我查询的是文件里的东西，
#而文件根本没这个内容
print "***添加组、key、值***"
config.set('huawei3','k3',3333)
#写入之前，组是必须存在的
config.write(open('configparsertest','w'))
print   "***删除组里的值***"
config.remove_section('huawei3')
config.write(open('configparsertest','w'))