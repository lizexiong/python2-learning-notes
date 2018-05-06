#!/usr/bin/python3
#--*-- coding:utf-8 --*--

import io,sys
sys.stdout = io.TextIOWrapper(sys.stdout.buffer,encoding='utf-8')

'''

以上如果二次引用,会报如下错误
ValueError: I/O operation on closed file

'''

import logging
logging.getLogger('scapy').setLevel(logging.ERROR)

from scapy.all import *
from random_library import *


def handshake(ip, port, randomip=False, get_result=True, establish=False,):
	random_obj = random_library()      #实例化random_num这个类
	source_ip = random_obj.random_ip()
	source_port = random_obj.random_port()
	init_sn = random_obj.random_sn()
	
	#如果randomip = True,那么IP就随机生成
	if randomip == True:
		# source_ip = random_obj.random_ip()
		#产生随机伪装源IP地址的TCP数据包，flags =2 发送syn请求连接包。
		tcp_packet = IP(src=source_ip,dst=ip)/TCP(dport=port,sport=source_port,flags=2,seq=init_sn)
	else:   #不伪装源地址,就使用本机地址
		tcp_packet = IP(dst=ip)/TCP(dport=port,sport=source_port,flags=2,seq=init_sn)

	if get_result == False:	#仅发送TCP包,并不需要接收回应的包
		send(tcp_packet, verbose =False,) #仅发送数据包,send是发送三层的包
		return 'send_only'
	else:
		try:
			syn_result = sr1(tcp_packet, verbose = False, timeout = 1) #发送并且接收回应包
			# print (syn_result.getlayer(TCP).fields['seq'],syn_result.getlayer(TCP).fields['ack'])

			#如果收到SYN ACK包,syn + ack = 18
			if syn_result.getlayer(TCP).fields['flags'] == 18 and syn_result.getlayer(IP).fields['src'] == ip:
				#如果不需要建立连接,就直接返回结果
				if establish == False:
					return (ip,port,syn_result.getlayer(TCP).fields['flags'],1)
				#如果希望建立连接,就构造ACK包并发回给对方
				elif establish == True:
					'''
					第一步: A → B,   发送SYN  ack为随机数,初始序列为0       seq=x
					第二步: B → A,   回包ACK  ack+1   ,初始序列产生			seq=y,ack=x+1
					第三步: A → B,   在发送ack, ack 没有变化,序列号 +1		ack=y+1

					总之最后回应的ack = seq +1
					'''
					#服务器回应过来的序列号 +1
					sc_sn = syn_result.getlayer(TCP).fields['seq'] +1
					#攻击客户端给服务器返回ack确认连接
					cs_sn = syn_result.getlayer(TCP).fields['ack']
					#回应给服务器的包, flags = 16 ,16为ack确认包,里面包含的数据
					send(IP(dst=ip)/TCP(dport=port,sport=source_port,flags=16,seq=cs_sn,ack=sc_sn),verbose=False)
					return (ip,port,syn_result.getlayer(TCP).fields['flags'],2)
			else:  #如果接收的不是SYN+ACK的包,就返回flags值
				return (ip,port,syn_result.getlayer(TCP).fields['flags'],2)
		except Exception as e:
			return 'conn_error'

# if __name__ == "__main__":
# 	handshake('192.168.100.100',80,randomip=False,get_result= False,establish=False)