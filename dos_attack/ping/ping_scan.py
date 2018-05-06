#!/usr/bin/python3
#--*-- coding:utf-8 --*--



import sys
import io

sys.stdout = io.TextIOWrapper(sys.stdout.buffer,encoding='utf-8')


from scapy.all import *
import logging
logging.getLogger("scapy").setLevel(logging.ERROR)

def scapy_ping_one(host):
	packet = IP(dst=host)/ICMP()/b'welcome to ShangHai' #构建ping数据包
	ping = sr1 (packet, timeout=2, verbose=False)#获取响应信息,超时时间为2秒,关闭调试信息

	try:
		if ping.getlayer(IP).fields['src'] == host and ping.getlayer(ICMP).fields['type'] == 0:
			#如果成功ping通,那么取出这个包里面我们需要的值
			return (host, 1)
		else:
			return (host, 2)
	except Exception as e:
		#一般如果ping不通,是没有值的
		return (host, 2)




import ipaddress     #自动计算该网段有多少IP,格式 l = ipaddress.ip_network('192.168.10.0/24')
import time
import multiprocessing

def scapy_ping_scan(network):

	try:
		net = ipaddress.ip_network(network)
	except Exception as e:
		print ("网段格式错误")
		return False
	ip_list = []
	for ip in net:
		ip_list.append(str(ip))  #把IP放入ip_list清单中
	pool = multiprocessing.Pool(processes=100)  #创建多进程的进程池,并发为100
	result = pool.map(scapy_ping_one, ip_list)  #创建映射关系
	pool.close() #关闭pool,不在加入新的进程
	pool.join() #等待每一个进程结束

	online_list = []
	for ip,ok in result:
		if ok == 1:
			online_list.append(ip)

	print ("在线主机列表:")
	for ip in online_list:
		print ("   " +ip)


	return online_list


if __name__ == "__main__":
	from optparse import OptionParser    #python处理命令行的模块
	usage = "python script.py -h 192.168.1.1 or python script.pyt 192.168.1.0/24"
	parser = OptionParser(usage=usage)

	parser.add_option("-t", "--target", action="store_true", #action:存储方式，分为三种store、store_false、store_true
	   dest="HostIP", 						#dest:存储的变量
	   default=False, 						#default:默认值
	   help="输入要扫描的主机IP,例:192.168.1.1") 

	parser.add_option("-s", "--segment", action="store_true", #action:存储方式，分为三种store、store_false、store_true
	   dest="Segment", 						#dest:存储的变量
	   default=False, 						#default:默认值
	   help="输入要扫描的网段,例:192.168.1.0/24") 

	(options, args) = parser.parse_args()
	if options.HostIP and options.Segment:
		print ("\033[1;31;46m usage \033[0m")
	elif options.HostIP:
		for ip in args:
			one_scan_result = scapy_ping_one(ip)

			ip,status = one_scan_result
			if status == 1:
				print ("主机 " + ip + " 在线")
			else:
				print ("主机 " + ip + " 不在线")
	elif options.Segment:
		scapy_ping_scan(args[0])



	# start_time = time.time()
	# result = scapy_ping_scan(sys.argv[1])
	# end_time = time.time()
	# scan_time = round(end_time - start_time,2)
	# print ('本次扫描用时: ' + str(scan_time) + "s")