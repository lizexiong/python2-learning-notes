# -*- coding: utf-8 -*-

import client

class command_handler(object):

    #首先初始化用户输入的参数
    def __init__(self,sys_args):
        self.sys_args = sys_args
        if len(self.sys_args)<2:exit(self.help_msg())
        self.command_allowcator()



    #然后把用户输入的指定拿到
    def command_allowcator(self):
        '''分捡用户输入的不同指令'''
       # print self.sys_args[1]

        #然后根据反射具体执行哪个函数，start或者stop
        if hasattr(self,self.sys_args[1]):
            func = getattr(self,self.sys_args[1])
            return func()
        else:
            print ("command does not exist!")
            self.help_msg()

    def help_msg(self):
        valid_commands = '''
        start       start monitor client
        stop        stop monitor client
        '''
        exit(valid_commands)

    def start(self):
        print("going to start the monitor client")
        #如果执行start,那么实例化一个对象，然后执行forver_run方法启动服务，现在去client里面查看ClientHandler类
        Client = client.ClientHandler()
        Client.forever_run()

