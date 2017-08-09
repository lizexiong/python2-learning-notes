#!/usr/bin/env python
#--*-- coding:utf-8 --*--

import subprocess,threading,datetime,os


host_list = {
    'itop':{'ip':'10.1.48.200','tar_dir':'/home/backup/itop/*','bf_dir':'/backup/pro/itop/'},
	'gonghui1':{'ip':'10.2.129.24','tar_dir':'/home/backup/gonghui1/*','bf_dir':'/backup/pro/gonghui1/'},
	'gonghui2':{'ip':'10.2.129.24','tar_dir':'/home/backup/gonghui2/*','bf_dir':'/backup/pro/gonghui2/'},
	'cangku':{'ip':'10.2.129.44','tar_dir':'/home/backup/cangku/*','bf_dir':'/backup/pro/cangku/'},
	'itsmm':{'ip':'10.2.129.37','tar_dir':'/home/backup/itsmm/*','bf_dir':'/backup/pro/itsmm/'},
	'chezhan':{'ip':'10.2.129.32','tar_dir':'/home/backup/chezhan/*','bf_dir':'/backup/pro/chezhan/'},
	'jianguandong':{'ip':'10.2.129.31','tar_dir':'/home/backup/jianguandong/*','bf_dir':'/backup/pro/jianguandong/'},
	'koudai':{'ip':'10.2.129.28','tar_dir':'/home/backup/koudai/*','bf_dir':'/backup/pro/koudai/'},
}


def backup_sync():
    for i in host_list.values():
        if not os.path.exists(i['bf_dir']):
			subprocess.call(["mkdir" + " " + i['bf_dir'] + " " + "-p"],shell=True)
        del_shell = 'find' + " " + i['bf_dir'] + " " + "-mtime +30 -name \"*.*\" -exec rm -rf {} \\;"
        sync_shell = 'rsync -avzH back@' + i['ip'] + ':' + i['tar_dir'] + ' ' + i['bf_dir']
        subprocess.call([del_shell],shell=True)
        subprocess.call([sync_shell],shell=True)

def run():
    t=threading.Thread(target=backup_sync,)
    t.start()


if __name__ == "__main__":
    run()




