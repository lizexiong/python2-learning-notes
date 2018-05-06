#!/bin/sh
host=`hostname`
dayahead30=`date -d"- 30days" +"%Y%m%d"`
echo $dayahead30
mon=`echo ${dayahead30:0:6}`
	currentday=$dayahead30
if [ ${#currentday} -ne 8 ]
then
	echo '日期错误'
	exit
fi
if [ ${#mon} -ne 6 ]
then
	echo '月份错误'
	exit
fi
	#echo /ossfs/blt-bak/access_log/201708/$currentday/$host/
	#mkdir -p /ossfs/blt-bak/access_log/201708/$currentday/$host/
	#mv /alidata/log/httpd/$mon/$currentday/* /ossfs/blt-bak/access_log/201708/$currentday/$host/
dest=/alidata/log/httpd/${mon}/${currentday}_${host}.tar.gz
src=/alidata/log/httpd/$mon/$currentday/
tar zcvf $dest -C /alidata/log/httpd/$mon/ $currentday
line=`tar ztf $dest | wc -l `
if [ $line -gt 1 ]
then
	if [ ${#src} -ne  35 ]
	then
		echo "路径错误"
		exit
	fi
	mkdir -p /ossfs/blt-bak/access_log/$mon/$currentday/
	mv $dest /ossfs/blt-bak/access_log/$mon/$currentday/

fi
