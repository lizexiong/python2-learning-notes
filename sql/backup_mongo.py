#!/usr/bin/env python
#--*-- coding:utf-8 --*--


import subprocess,threading,datetime,os

#time
now = datetime.datetime.now()
#otherStyleTime = now.strftime("%Y-%m-%d %H:%M:%S")
otherStyleTime = now.strftime("%Y%m%d-%H%M")

#host information
host_list = {
	'mysql':{	
#		'itop':{'ip':'10.1.48.200','db_user':'back','db_passwd':'back@xunnuo@huawei.com','db_name':'itop','db_dir':'/backup/sql/itop/'},
		'909':{'ip':'10.2.129.29','db_user':'back','db_passwd':'back@xunnuo@huawei.com','db_name':'meeting_manage','db_dir':'/backup/sql/909/'},
#		'cangku':{'ip':'10.2.129.44','db_user':'back','db_passwd':'back@xunnuo@huawei.com','db_name':'mobistars','db_dir':'/backup/sql/cangku/'},
#		'chezhan':{'ip':'10.2.129.32','db_user':'back','db_passwd':'back@xunnuo@huawei.com','db_name':'station_manage','db_dir':'/backup/sql/chezhan/'},
#		'gonghui1':{'ip':'10.2.129.24','db_user':'back','db_passwd':'back@xunnuo@huawei.com','db_name':'shentongunion','db_dir':'/backup/sql/gonghui1/'},
#		'gonghui2':{'ip':'10.2.129.24','db_user':'back','db_passwd':'back@xunnuo@huawei.com','db_name':'shentongunion2','db_dir':'/backup/sql/gonghui2/'},
#		'jianguandong':{'ip':'10.2.129.31','db_user':'back','db_passwd':'back@xunnuo@huawei.com','db_name':'constructionmanager','db_dir':'/backup/sql/jianguandong/'},
#		'pingan':{'ip':'10.2.128.11','db_user':'back','db_passwd':'back@xunnuo@huawei.com','db_name':'volunteer','db_dir':'/backup/sql/pingan/'},
#		'zhangshangyunguan':{'ip':'10.2.129.26','db_user':'back','db_passwd':'back@xunnuo@huawei.com','db_name':'metro_mobile','db_dir':'/backup/sql/zhangshangyunguan/'},
			},
	'mongo':{
		'youxuan':{'ip':'10.2.129.29','db_user':'','db_passwd':'','db_name':'CommonDB','db_dir':'/backup/sql/youxuan_CommonDB/'},
		'youxuan':{'ip':'10.2.129.29','db_user':'','db_passwd':'','db_name':'News909','db_dir':'/backup/sql/youxuan_News909/'},
		'youxuan':{'ip':'10.2.129.29','db_user':'','db_passwd':'','db_name':'News909','db_dir':'/backup/sql/youxuan_News909/'}
#		'unified':{'ip':'10.2.129.29','db_user':'','db_passwd':'','db_name':'News909','db_dir':'/backup/sql/unified/'},
			},
}


def backup_sql():
	for sql_type,host in host_list.items():
		for i,j in host.items():
			if not os.path.exists(j['db_dir']):
				subprocess.call(["mkdir" + " " + j['db_dir'] + " " + "-p"],shell=True)
			b_name = j['db_dir'] + otherStyleTime + "_" + j['db_name']
			b_name_sql = j['db_dir'] + otherStyleTime + "_" + j['db_name'] + ".sql"
			if sql_type == 'mysql':
				db_shell = 'mysqldump -u' + j['db_user'] + " " +'-p' + j['db_passwd'] + " " +'-h' + " " + j['ip'] + " " + j['db_name'] + " " + ">" + " " + b_name_sql
				tar_shell = 'tar -zcf' + " " + b_name + ".tar.gz" + " " + b_name_sql + " " + "--remove &> /dev/null"
				del_shell = 'find' + " " + j['db_dir'] + " " + "-mtime +30 -name \"*.*\" -exec rm -rf {} \\;"
			elif sql_type == 'mongo':
				db_shell = 'mongodump' + " " + '-h' + " " + j['ip']+ " " +'-d' + " " + j['db_name'] + " " +'-o' + " " + j['db_dir']
				tar_shell = 'tar -zcf' + " " + b_name + ".tar.gz" + " " + j['db_dir'] + " " + "--remove &> /dev/null"
				del_shell = 'find' + " " + j['db_dir'] + " " + "-mtime +30 -name \"*.*\" -exec rm -rf {} \\;"
			subprocess.call([db_shell],shell=True)
			subprocess.call([tar_shell],shell=True)
			subprocess.call([del_shell],shell=True)


def run():
	t = threading.Thread(target=backup_sql,)
	t.start()

if __name__ == "__main__":
	run()
	
	
	
	
