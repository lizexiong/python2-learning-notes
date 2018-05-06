# -*- coding: utf-8 -*-

'''
    主要获取本机ip以及mac地址
'''


import sys,io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer,encoding='utf-8')


from scapy.all import *



def get_ip_mac(ifname=None):
    '''
    通过网卡名获取本机ip以及mac,如果有多个网卡名,那么就是一个列表来存储
    :param ifname:
    :return:
    '''
    all_ifname = os.popen("ifconfig | cut -d' ' -f1 | cut -d : -f 1 | grep -v '^$'").read().split('\n')
    print ('all_ifname:',all_ifname)
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
    return (ip_info,all_ifname)

def network_dict(ifname=None,):
    '''
    将各网卡的信息生成{ip:mac}格式返回
    :param ifname:
    :return:
    '''
    ip_info = []
    ip_mac_dict = {}
    if isinstance(ifname,list):
        for i in ifname:
            ip = ip_matching(i)
            mac = mac_matching(i)
            ip_mac_dict[i] = {ip:mac}
    else:
        ip = ip_matching(ifname)
        mac = mac_matching(ifname)
        ip_mac_dict[ifname] = {ip:mac}

    #将得到的{ip:mac}字典返回
    ip_info.append(ip_mac_dict)

    #后台调试打印网卡及地址
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


