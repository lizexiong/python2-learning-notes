#!/bin/bash
static_path=/home/djb/release/static
app_path=/home/djb/release/app
module_path=/home/djb/release/module
staic_num="0"
continue_num="0"
#磁盘监控
disk_use="`df -hT|awk -F "[ ]+" 'NR==2{print $6}'|cut -b 1-2`"
if [ $disk_use -lt 80 ];then
	exit
fi
#静态目录清理
hanghao="`ls $static_path |wc -l`"
tail="$[$hanghao - 3]"
num="`ls $static_path |sed -n "1,$tail p"|cut -b 5-6|uniq -c|cut -b 7`"
name="`ls $static_path |sed -n "1,$tail p"|cut -b 5-6|uniq -c|cut -b 9-10`"
for i in $name
do
	for j in $num
	do
		#跳出判断
		if [ $continue_num != 0 ];then
			continue_num="$[$continue_num - 1 ]"
			continue
		fi
		#数量判断
		if [ $j -gt 1 ];then
			value="`ls static_path | grep "2017$i"`"
			for k in $value
			do
				rm -rf $static_path/$k
				count="`ls $static_path|grep "2017$i"|wc -l`"
				if [ "$count" == 1 ];then
					break
				fi
			done
		fi
		static_num="$[$static_num + 1]"
		continue_num="$static_num"
		break
	done
done


#module 目录清理
hanghao2="`ls $module_path |wc -l`"
tail2="$[$hanghao2 - 3]"
num2="`ls $module_path |sed -n "1,$tail2 p"|cut -b 5-6|uniq -c|cut -b 7`"
name2="`ls $module_path |sed -n "1,$tail2 p"|cut -b 5-6|uniq -c|cut -b 9-10`"
module_num="0"
continue_num="0"
for i in $name2
do
	for j in $num2
	do
		#跳出判断
		if [ $continue_num != 0 ];then
			continue_num="$[$continue_num - 1 ]"
			continue
		fi
		#数量判断
		if [ $j -gt 1 ];then
			value="`ls module_path | grep "2017$i"`"
			for k in $value
			do
				rm -rf $module_path/$k
				count="`ls $module_path|grep "2017$i"|wc -l`"
				if [ "$count" == 1 ];then
					break
				fi
			done
		fi
		module_num="$[$static_num + 1]"
		continue_num="$static_num"
		break
	done
done

#app目录清理
hanghao3="`ls $app_path |wc -l`"
tail3="$[$hanghao3 - 3]"
num3="`ls $app_path |sed -n "1,$tail3 p"|cut -b 5-6|uniq -c|cut -b 7`"
name3="`ls $app_path |sed -n "1,$tail3 p"|cut -b 5-6|uniq -c|cut -b 9-10`"
app_num="0"
continue_num="0"
for i in $name3
do
	for j in $num3
	do
		#跳出判断
		if [ $continue_num != 0 ];then
			continue_num="$[$continue_num - 1 ]"
			continue
		fi
		#数量判断
		if [ $j -gt 1 ];then
			value="`ls $app_path | grep "2017$i"`"
			for k in $value
			do
				rm -rf $app_path/$k
				count="`ls $app_path|grep "2017$i"|wc -l`"
				if [ "$count" == 1 ];then
					break
				fi
			done
		fi
		app_num="$[$static_num + 1]"
		continue_num="$static_num"
		break
	done
done
