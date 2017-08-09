#!/usr/bin/env python
#--*-- coding:utf-8 --*--


import subprocess,threading,datetime,os

#时间信息
now = datetime.datetime.now()
#otherStyleTime = now.strftime("%Y-%m-%d %H:%M:%S")
otherStyleTime = now.strftime("%Y-%m-%d-%H:%M")

#数据库信息
db_host = '192.168.16.223'
db_user = 'back'
db_passwd = 'back@xunnuo@huawei.com'
db_name = 'mysql'
db_dir = '/backup/sql/juntech/'


b_name = db_dir + otherStyleTime + "_" + db_name 
b_name_sql = db_dir + otherStyleTime + "_" + db_name + ".sql"

db_shell = 'mysqldump -u' + db_user + " " +'-p' + db_passwd + " " +'-h' + " " + db_host + " " + db_name + " " + ">" + " " + b_name_sql
tar_shell = 'tar -zcf' + " " + b_name + ".tar.gz" + " " + b_name_sql + " " + "--remove &> /dev/null"
del_shell = 'find' + " " + db_dir + " " + "-mtime +30 -name \"*.*\" -exec rm -rf {} \\;"

def backup_sql():
	if not os.path.exists(db_dir):
		subprocess.call(["mkdir" + " " + db_dir + " " + "-p"],shell=True)		
	subprocess.call([db_shell],shell=True)
	subprocess.call([tar_shell],shell=True)
	subprocess.call([del_shell],shell=True)
	
def run():
	t = threading.Thread(target=backup_sql,)
	t.start()

if __name__ == "__main__":
	run()
	
	
	
	
