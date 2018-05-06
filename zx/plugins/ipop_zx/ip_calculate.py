# -*- coding: utf-8 -*-

from IPy import IP

def subnet_calculate(ip,mask):

	ip_split = ip.split('.')
	if len(ip_split) != 4:
		result = {'network':'ip error'}
		return result
	for i in ip_split:
		if i.isdigit() == True and int(i) > 0 and int(i) < 255:
			pass
		else:
			result = {'network':'ip error'}
			return result

	mask_split = mask.split('.')
	if len(mask_split) != 4:
		result = {'network':'mask error'}
		return result
	for i in mask_split:
		if i.isdigit() == True and int(i) >= 0 and int(i) < 256:
			pass
		else:
			result = {'network':'mask error'}
			return result
	try:
		network = str(IP(ip).make_net(mask))
		result = {'network':network}
	except Exception:
		result = {'network':'calculate error'}
	return result


def all_ip(network):
	return list(IP(network))