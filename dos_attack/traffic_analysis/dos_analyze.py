#!/usr/bin/python3
#--*-- coding:utf-8 --*--


import io,sys
sys.stdout = io.TextIOWrapper(sys.stdout.buffer,encoding='utf-8')


import logging
logging.getLogger('scapy').setLevel(logging.ERROR)

from scapy.all import *
import re

def finddos(filename):
	pcap_file = rdpcap(filename)
	#首先读取成为结果
	plist = pcap_file.res
	#存储dos的字段
	dos_dict = {}


	for packet in plist:
		try: #总有一些包是空值,那么就会报错
			#如果判断这个包是syn请求连接包,那么开始记录,syn=2
			if packet.getlayer('TCP').fields['flags'] == 2:
					#从IP层取出源地址,目标地址
					source_ip = packet.getlayer('IP').fields['src']
					des_ip = packet.getlayer('IP').fields['dst']
					#从tcp层取出目标端口
					des_port = packet.getlayer('TCP').fields['dport']
					#将源地址,目标地址,目标端口生成一个元祖
					socket = source_ip, des_ip, des_port

					if dos_dict.get(socket):  #如果存在这个键
						#把元祖当成字典的键,次数当成值
						dos_dict[socket] = dos_dict[socket] + 1
					else:
						dos_dict[socket] = 1
						# print (source_ip)
		except Exception as e:
			pass

	'''
	sort 是应用在 list 上的方法，sorted 可以对所有可迭代的对象进行排序操作。
	list 的 sort 方法返回的是对已经存在的列表进行操作，
	而内建函数 sorted 方法返回的是一个新的 list，而不是在原来的基础上进行的操作。
	key -- 主要是用来进行比较的元素，只有一个参数，
	具体的函数的参数就是取自于可迭代对象中，指定可迭代对象中的一个元素来进行排序。

	主要是lambda这里, x:x[1]  一个字典传进来,被sorted处理,那么key和values就有2个下标。
	如果使用x:x[0]就是用Key排序

	'''
	dos_dict = sorted(dos_dict.items(),key = lambda x:x[1],reverse = True)
	# print (dos_dict)

	for dos_list in dos_dict:
		if int(dos_list[1]) > 3:
			detection_result =('DOS攻击检查脚本检查到可疑源,源为: ' +dos_list[0][0] + "目标为: " + dos_list[0][1] + "目标端口为: " + str(dos_list[0][2]) + "连接次数为: " + str(dos_list[1]) )
			print (detection_result)

	#不需用排序输出使用此函数
	# for socket, num in dos_dict.items():
	# 	if num >= 1:
	# 		detection_result =  ('DOS攻击检查脚本检查到可疑源,源为: ' +socket[0] + "目标为: " + socket[1] + "目标端口为: " + str(socket[2]) + "连接次数为: " + str(num) )
	# 		print (detection_result)

finddos('dos.pcap',)