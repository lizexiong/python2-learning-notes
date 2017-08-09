#!/usr/bin/env python
#--*-- coding:utf-8 --*--

import MySQLdb

#简历数据库连接
conn = MySQLdb.connect('192.168.100.50',user='root',passwd='',db='test')
cur = conn.cursor()

#在Python-mysql,只有%s


reCount = cur.execute('select * from test.name')

print cur.fetchone()
print cur.fetchone()
cur.scroll(-1,mode='relative')
print cur.fetchone()
cur.scroll(0,mode='absolute')
print cur.fetchone()

#一定要按顺序关闭连接
cur.close()
conn.close()
