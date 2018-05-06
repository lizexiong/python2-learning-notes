#!/bin/bash
#tomcat 日志切割


while true 
do
log_dir="/usr/local/tomcat/logs/"
log_file="/usr/local/tomcat/logs/catalina.out"
file_size=`du -b $log_file | awk '{print $1}'`
if [ $file_size -gt 3145728 ]
then
	echo $file_size"trigger"
	cp $log_file $log_dir"catalina-`date +%Y-%m-%d-%H:%M:%S`".log
	echo `date +%Y-%m-%d-%H:%M:%S`"log_incise" >> $log_dir"split".log
	echo "" > $log_file
fi
sleep 3
done
