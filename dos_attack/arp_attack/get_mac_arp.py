#!/usr/bin/python3
# -*- coding: utf-8 -*-


from scapy.all import * 

def get_mac_arp(localip,localmac,goalip,ifname):
	result_raw = srp(Ether(src=localmac,dst="FF:FF:FF:FF:FF:FF")/
		ARP(op=1,hwsrc=localmac,hwdst='00:00:00:00:00:00',psrc=localip,pdst=goalip),iface=ifname,verbose=False)
	# print (result_raw[0].res[0][1][1].fields['hwsrc'])
	return result_raw[0].res[0][1][1].fields['hwsrc']

# get_mac_arp(localip,localmac,goalip,ifname)