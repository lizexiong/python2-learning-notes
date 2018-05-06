#!/usr/bin/python3
#--*-- coding:utf-8 --*--



import time
import threading
from tcp_handshake import handshake
from thread_result import MyThread



def tcp_scan(host,port_low=1,port_high=1024):
	ports = list(range(port_low,port_high))
	ports_list = []

	for i in ports:
		t = MyThread(handshake,args=(host,i,False,True,False))
		t.start()
		t.join() #一定要join，不然主线程比子线程跑的快，会拿不到结果
		ports_list.append(t.get_result())

	print ("在线端口为:")
	print ("   ",end='')
	for i in ports_list:
		if i[3] == 1:
			print (str(i[1]) + ", ",end='')
	print ('')


if __name__ == "__main__":
	from optparse import OptionParser    #python处理命令行的模块
	usage = "python script.py -t 192.168.1.1 -l 1 -g 1024"
	parser = OptionParser(usage=usage)

	parser.add_option("-t", "--target", action="store_true", #action:存储方式，分为三种store、store_false、store_true
	   dest="HostIP", 						#dest:存储的变量
	   default=False, 						#default:默认值
	   help="输入要扫描的主机IP,例:192.168.1.1")

	parser.add_option("-l", "--port_low", action="store_true",
		dest="port_low",
		default=False,
		help="输入要扫描的主机IP的起始端口号")

	parser.add_option("-g", "--port_high", action="store_true",
 		dest="port_high", 						#dest:存储的变量
	   	default=False, 						#default:默认值
	   	help="输入要扫描的主机IP的结束端口号")

	(options, args) = parser.parse_args()
	start_time = time.time()
	if options.HostIP and options.port_low and options.port_high:
		tcp_scan(args[0],int(args[1]),int(args[2]))
	elif options.HostIP and options.port_high:
		tcp_scan(args[0],port_high=int(args[1]))
	elif options.HostIP:
		tcp_scan(args[0])
	else:
		print (usage)