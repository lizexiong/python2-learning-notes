#!/usr/bin/python3
#--*-- coding:utf-8 --*--



import random

class random_library(object):
	def __init__(self,):
		pass

	def random_ip(self,):
		one_section = random.randint(1,254)
		two_section = random.randint(1,254)
		three_section = random.randint(1,254)
		four_section = random.randint(1,254)
		ip = str(one_section) + "." + str(two_section) + "." + str(three_section) + "." + str(four_section)
		return ip

	def random_port(self,):
		return random.randint(1024,65535)

	def random_sn(self,):
		return random.randint(1,65535*65535)

# random_library = random_num()
# print (random_library.random_ip())