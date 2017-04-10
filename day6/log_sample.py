#!/usr/bin/env python
#--*-- coding:utf-8 --*--

import logging

#filename为日志文件的名称；format为日志格式，是固定格式，但是可以自己组合；
#level 是日志默认等级，一般如果等于这个等级，那么就会记录这个等级以下的日志
logging.basicConfig(filename='apache.log',
                    format='%(asctime)s - %(name)s - %(levelname)s - %(module)s: %(message)s',
                    datefmt='%Y-%m-%d %H:%M:%S',
                    level=__debug__
)

# logging.debug('this is a debug messages')
# logging.info('info')
# logging.warning('warning')
# logging.error('error')
# logging.critical('critical')
# logging.log(10,'log')

while 1:
    num = raw_input("请输入数字")
    if num.isdigit():
        print num
        logging.info('info')
    else:
        logging.error('error')
