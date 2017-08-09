#!/usr/bin/env python
#--*-- coding:utf-8 --*--

import subprocess,threading,datetime,os

#时间信息
now = datetime.datetime.now()
#otherStyleTime = now.strftime("%Y-%m-%d %H:%M:%S")
otherStyleTime = now.strftime("%Y%m%d-%H%M%S")


#用户输入信息
BF_DIR="/home/backup/itop/"
DB="shentong"
DB_DIR="/usr/local/tomcat/webapps/"
DB_NAME = otherStyleTime + "_" + DB + ".tar.gz"
tar_shell = 'tar zcf' + " " + BF_DIR + DB_NAME + " " + DB_DIR + DB 
del_shell = 'find' + " " + BF_DIR + " " + "-mtime +1 -name \"*.*\" -exec rm -rf {} \\;"
set_shell = "setfacl -R -m user:back:rwx" + " " + BF_DIR

def backup_pro():
	if not os.path.exists(BF_DIR):
		subprocess.call(["mkdir" + " " + BF_DIR + " " + "-p"],shell=True)
		#subprocess.call(["cd" + " " + BF_DIR],shell=True)
		#subprocess.call(["cd" + " " + BF_DIR],shell=True)
	subprocess.call([tar_shell],shell=True)
	subprocess.call([del_shell],shell=True)
	subprocess.call([set_shell],shell=True)


def run():
	t= threading.Thread(target=backup_pro,)
	t.start()

if __name__ == "__main__":
	run()