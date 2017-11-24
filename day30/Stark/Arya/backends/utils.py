# -*- coding: utf-8 -*-

import sys

from Arya import action_list
#外部python脚本调用django项目中的方法、模型等(setup_environ)
import django
django.setup()

from Stark import settings
from Arya import models

class ArgvManagement(object):
    '''
    接收用户指令并分配到相应模块
    '''
    def __init__(self,argvs):
        self.argvs = argvs
        self.argv_parse()

    def help_msg(self):
        print("Available modules:")
        for registered_module in action_list.actions:
            print("  %s" % registered_module)
        exit()

    def argv_parse(self):
        if len(self.argvs) < 2:
            self.help_msg()
        module_name  = self.argvs[1]
        if '.' in module_name:
            '''
            mod_name =  cmd(state)    mod_method = run(apply)
          '''
            mod_name,mod_method = module_name.split('.')
            print ('mod_name:',mod_name,'mod_method:',mod_method)
            #module_instance = <class 'Arya.plugins.cmd.CMD'>
            module_instance = action_list.actions.get(mod_name)
            print ('module_instance',module_instance)
            if module_instance:#matched
                '''
                module_instance = action_list 的'cmd':cmd.CMD,  CMD这个类，CMD又继承BaseSaltMoudle类
              '''
                module_obj = module_instance(self.argvs,models,settings)
                module_obj.process()#解析任务，发送到队列
                if hasattr(module_obj,mod_method):
                    module_method_obj = getattr(module_obj,mod_method)#解析任务，发送到队列，取任务结果
                    module_method_obj() #调用指定的指令,比如state.apply  apply的方法，里面是-f处理文件的
                else:
                    exit("module [%s] doesn't have [%s] method" % (mod_name,mod_method))

        else:
            exit("invalid module name argument")
