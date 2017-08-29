#!/bin/bash

current_time=`date '+%Y-%m-%d %H:%M:%s'`

/usr/bin/python /home/djb/bin/app.py $*

echo "$current_time : $*" >> `dirname $0`/app.log
