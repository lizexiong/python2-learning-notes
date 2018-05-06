# -*- coding: utf-8 -*-
import tornado.httpserver
import tornado.ioloop
import tornado.web
import tornado.netutil
import tornado.process


from tornado.options import define, options, parse_command_line

import sys
from applications import application,PORT


def start_application():
	#加载环境配置项
	'''
	上边代码中define("port", default=8888, help="run on the given port", type=int)这句，
	当在终端输入helloworld.py --help的时候，将会有“--port run on the given port (default 8888)”的提示。
	'''
	define('port',default=PORT,type=int,help=u"run on the port")
	'''	tornado.options.parse_command_line()这一行是对命令行进行解析，格式：("--myoption=myvalue")。也可以是配置文件解析tornado.options.parse_config_file("/etc/server.conf")，配置文件必须是python文件，像：
	myoption = "myvalue"
	myotheroption = "myothervalue"
	参数指定类型type可以是：datetimes, timedeltas, ints, and floats
	'''
    #parse_command_line()  #单线程可不写
	print ('serve listen port %s' % options.port)
    # sockets = tornado.netutil.bind_sockets(PORT)
    # tornado.process.fork_processes(2)
    # server = tornado.httpserver.HTTPServer(application)

	application.listen(options.port,address="0.0.0.0")

	tornado.ioloop.IOLoop.instance().start()

if __name__ == "__main__":
    start_application()


