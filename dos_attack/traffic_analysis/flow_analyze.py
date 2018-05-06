#!/usr/bin/python3
#--*-- coding:utf-8 --*--



# import io,sys
# sys.stdout = io.TextIOWrapper(sys.stdout.buffer,encoding='utf-8')



import logging
logging.getLogger('scapy').setLevel(logging.ERROR)

from scapy.all import *
import re

def pkg_perser(filename,keyword):
	# try:
	pkts = rdpcap(filename,)   #scapy的内置方法,读出包的内容,使用res来生成列表列表清单,然后在对列表操作
	pkts_list = [] #返回匹配数据包的清单
	# print (pkts[3].getlayer('Raw').fields['load'].decode('utf-8'))
	re_keyword = '.*' + keyword + '.*' 
	for pkt in pkts.res:
		'''
		这里有IP层,TCP,Raw,不同的层次有不同的数据,比如IP里面有源IP等，
		这里的比较基础,主要是需要Raw的数据，下面讲解
		'''
	#print (pkg['IP'].src)
	#print (pkg.show2())			#这条命令可以看看有哪些层次和哪些字段
		
		'''
			因为下面Raw层次有很多东西都是空的,那么type就是NoneType类型,是没有方法的,所以会报错
			所以这里要用一个判断，如果不是你呢挂钩decode的数据,直接pass吧
		'''
		try: 
			#IP,TCP也可以用这种方式来获取src,dst						
			raw_result = pkt.getlayer('Raw').fields['load'].decode().strip()
			if re.match(re_keyword,raw_result) and pkt.getlayer('TCP').fields['sport'] == 21:
				#如果匹配到需要的字段,那么就将该包放入列表里面
				pkts_list.append(pkt.getlayer('Raw').fields['load'].decode().strip())
		except Exception as e:
			pass

	return pkts_list

test = pkg_perser("ftp.pcap",'cannot')
print (test)