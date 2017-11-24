# -*- coding: utf-8 -*-


import MySQLdb

conn=MySQLdb.connect(host="localhost",user="root",passwd="huawei",db="test",charset="utf8")
cursor = conn.cursor()

cursor.execute("select version()")
data = cursor.fetchone()
print (data)

