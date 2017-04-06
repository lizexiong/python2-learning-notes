#!/usr/bin/env python
#--*-- coding:utf-8 --*--

import os
import sys

userfile =file('test.txt', 'r+')
userlist = []
userdict = {}

if os.path.isfile('test.txt'):
	pass
else:
	print '没有定义此文件!'
	sys.exit

for i in userfile:
	line = i.strip()
	value_list = line.split(',')
	value_name = value_list[0].strip()
	value_pwd = value_list[1].strip()
	value_login = int(value_list[2])
	value_vadm = int(value_list[-1])
	userdict[value_name] = {'name':value_name,'pwd':value_pwd,'login':value_login,'vadm':value_vadm}


flag = 'True'
count = 0
while flag :
	username = raw_input("Please in username")
	userpwd = raw_input("Please in passwd")
	if username not in userdict.keys():
		print "not is user"
		break;
	elif userdict[username]['vadm'] == 0  and userdict[username]['login'] < 3:
		if userpwd == userdict[username]['pwd'].strip():
			print "welcome in shanghai"
			break;
		else:
			count += 1
			userdict[username]['login'] += 1
			for t in userdict.values():
				wuserlist = [str(t['name']), str(t['pwd']), str(t['login']), str(t['vadm'])]
				wuserlist_str = ','.join(wuserlist)
				userfile.write(wuserlist_str + '\n')
			if count>2:
				print "passwd > 3"
				break;
	else:
		print "account is lock"
		sys.exit("Please admin jie lock")
	continue;
userfile.close()
			
	
