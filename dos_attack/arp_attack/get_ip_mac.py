#!/usr/bin/python3
# -*- coding: utf-8 -*-



import os 
import sys  
# import io

# sys.stdout = io.TextIOWrapper(sys.stdout.buffer,encoding='utf-8')


def get_ip_mac(ifname=None):
	all_ifname = os.popen("ifconfig | cut -d' ' -f1 | cut -d : -f 1 | grep -v '^$'").read().split('\n')
	while '' in all_ifname:
		all_ifname.remove('')
	if ifname == None:
		ip_info = network_dict(all_ifname)
	else:
		if ifname in all_ifname:
			ip_info = network_dict(ifname)
		else:
			print ('\033[1;31;47m没有此网卡\033[0m')
			return False
		# 	if_result = os.popen('ifconfig %s' %(ifname)).read().strip()
		# 	print (if_result)
		# all_ifname_result = all_ifname_result.split("\n")
		# for i in all_ifname_result:
		# 	print (i)	

		# if_result_tmp = os.popen("ifconfig %s" %(ifname))
		# if_result = if_result_tmp.read()
	return ip_info

def network_dict(ifname=None,):
	ip_info = []
	ip_mac_dict = {}
	if isinstance(ifname,list):
		for i in ifname:
			ip = ip_matching(i)
			mac = mac_matching(i)
			ip_mac_dict[i] = {ip:mac}
		ip_info.append(ip_mac_dict)
	else:
		 ip = ip_matching(ifname)
		 mac = mac_matching(ifname)
		 ip_mac_dict[ifname] = {ip:mac}
		 ip_info.append(ip_mac_dict)
	
	#打印网卡信息
	for ifname_ip_mac in ip_info:
		for ifname,ip_mac in ifname_ip_mac.items():
			for ip,mac in ip_mac.items():
				 result = ('\033[1;31;47m网卡: \033[0m' + ifname + ' \033[1;31;47m,IP地址为:\033[0m' + ip + ' \033[1;31;47m,MAC地址为:\033[0m' + mac)
				 print (result)

	return ip_info	 

def ip_matching(ifname):
	ip = os.popen("ifconfig %s | grep -v 'inet6' | grep 'inet' | awk  '{print $2}'" %(ifname)).read().strip()
	return ip

def mac_matching(ifname):
	mac = os.popen("ifconfig %s | grep 'ether' | awk  '{print $2}'" %(ifname)).read().strip()
	return mac


