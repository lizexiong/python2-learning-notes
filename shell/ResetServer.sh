#!/bin/bash
source /etc/profile

curTime=$(date "+%Y-%m-%d-%H:%M:%S")
curPwd=$(dirname $0)/logResetSer
echo $curPwd
if [ ! -d $curPwd ];then
	mkdir $curPwd
fi
function ResetServer()
{
	/etc/init.d/mysqld stop 1>/dev/null
	if [ $? -ne 0 ];then
		echo $curTime '_Server Stop Fail...' >> $curPwd/ResetFail.txt
		return '1'
	else
		echo $curTime  '_Server Stop Sucessful...' >> $curPwd/ResetSucc.txt
		find /tmp/ -name "*.ts" -exec rm -rf {} \; &>/dev/null
		if [ $? -ne 0 ];then
			echo $curTime "_Delete File Fail..." >> $curPwd/ResetFail.txt
			return '1'
		else	
			echo $curTime  '_Delete File Sucessful...' >> $curPwd/ResetSucc.txt
			sleep 10
			/etc/init.d/mysqld start
		fi
	fi
}

ResetServer
