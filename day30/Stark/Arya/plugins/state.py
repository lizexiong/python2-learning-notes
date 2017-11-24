# -*- coding: utf-8 -*-

from Arya.backends.base_module import BaseSaltModule
from Arya.backends import tasks
import os

class State(BaseSaltModule):



    def load_state_files(self,state_filename):
        from yaml import load, dump
        try:
            #因为系统版本或者版本限制,如果导入这些报错，那么就直接导入下面的版本
            from yaml import CLoader as Loader, CDumper as Dumper
        except ImportError:
            from yaml import Loader, Dumper
        state_file_path = "%s/%s" %(self.settings.SALT_CONFIG_FILES_DIR,state_filename)
        if os.path.isfile(state_file_path):
            with open(state_file_path) as f:
                #整个函数最重要的，直接把文件读书变成字典格式
                data = load(f.read(), Loader=Loader)
                return data
        else:
            exit("%s is not a valid yaml config file" % state_filename)


    def apply(self):
        '''
        1. load the configurations file
        2. parse it
        3. create a task and sent it to the MQ
        4. collect the result with task-callback id
        :return:
        '''

        if '-f' in self.sys_argvs:
            yaml_file_index = self.sys_argvs.index('-f') + 1
            try:
                yaml_filename = self.sys_argvs[yaml_file_index]
                #调用一个函数处理yaml_filename文件
                state_data = self.load_state_files(yaml_filename)
                # print ('state_data',state_data)
                for os_type,os_type_data in self.config_data_dic.items():#按照不同的操作系统单独生成一份配置文件
                    for section_name,section_data in state_data.items():
                        print('Section:',section_name)


                        for mod_name,mod_data in section_data.items():
                            print (" ",mod_name)
                            #base_mod_name = user.present 或者 group.present的0下标
                            base_mod_name =mod_name.split(".")[0]
                            module_obj = self.get_module_instance(base_mod_name=base_mod_name,os_type=os_type)
                            #把所有数据传过去语法分析
                            module_parse_result = module_obj.syntax_parser(section_name,mod_name,mod_data,os_type)
                            self.config_data_dic[os_type].append(module_parse_result)
                print (self.config_data_dic)
                #最后self就是state实例自己
                new_task_obj = tasks.TaskHandle(self.db_models,self.config_data_dic,self.settings,self)
                new_task_obj.dispatch_task()
                #代表上面所有数据解析完成，接下来生成一个任务,并把任务放入队列结果
                        # for state_item in mod_data:
                        #     print ('\t',state_item)
            except IndexError as e:
                exit("必须在后面提供状态文件 -f")
        else:
            exit('-f参数都没有加')