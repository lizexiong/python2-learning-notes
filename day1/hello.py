#!/usr/bin/env python
#--*-- coding:utf-8 --*--

file_obj = file('test.txt', 'r+')

line_list = file_obj.readlines()
my_list =[]

for i in line_list:
	#去掉空格回车strip方法
	line = i.strip()
	#根据逗号将字符串改变成列表
	value_list = line.split(',')
	#取出列表最后一个值并转换成整形
	last_value = int(value_list[-1])
	#最后一个值每循环一次+1
	last_value += 1
	#将列表的最后一个元素赋值给自增之后的值,
	#这里将last_value变成字符串是因为，join只能识别字符串
	value_list[-1] = str(last_value)
	#重新生成一个字符串，join变成字符串，用，隔开
	#也可以说将列表用join来转换成字符串
	value_str = ','.join(value_list)
	#生成my_list来接收value_str的值，将
	my_list.append(value_str)
	#将列表转换为字符串，因为文件只能存储字符串
my_str = '\n'.join(my_list)

file_obj.write(my_str)
	 
file_obj.close()