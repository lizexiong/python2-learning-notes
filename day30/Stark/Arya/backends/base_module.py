# -*- coding: utf-8 -*-


import os

class BaseSaltModule(object):
    def __init__(self,sys_argvs,db_models,settings):
        self.db_models = db_models
        self.sys_argvs = sys_argvs
        self.settings = settings

    def argv_validation(self,argv_name,val,data_type):
        if type(val) is not data_type:
            exit("Error:[%s] data type is not valid")

    def get_selected_os_types(self):
        data = {}
        for host in self.host_list:
            data[host.os_type] = []
        print('--->data',data)
        return data

    def process(self):
        self.fetch_hosts()
        self.config_data_dic = self.get_selected_os_types()

    def is_required(self,*args,**kwargs):
        print ('Error: is required() method must be implemented in module class [%s]'% args[0])
        username = args[1]

    #在本代码80行调用
    def require(self,*args,**kwargs):
        print ('in requre',args,kwargs)
        os_type = kwargs.get('os_type')

        self.require_list = []
        for item in args[0]:
            # print ('item',item)
            #item = pkg: apache
            for mod_name,mod_val in item.items():
                module_obj = self.get_module_instance(base_mod_name=mod_name,os_type=os_type)
                require_condition = module_obj.is_required(mod_name,mod_val)
                # print ('require_condition',require_condition)
                self.require_list.append(require_condition)

                # print (module_obj)
        print ("require_list [%s]---[%s]" %(mod_name,self.require_list))

    #提取主机
    def fetch_hosts(self):
        print ('Fetch Hosts')

        if '-h' in self.sys_argvs or '-g' in self.sys_argvs:
            host_list = []
            if '-h' in self.sys_argvs:
                # -h +1  的索引位置的参数正好是主机名
                host_str_index = self.sys_argvs.index('-h') + 1
                print ('host_str_index',host_str_index)
                if len(self.sys_argvs) <= host_str_index:
                    exit('必须在后面提供主机参数')
                else:
                    #sys_argvs下标为3正好为主机名
                    host_str = self.sys_argvs[host_str_index]
                    print ('host_str',host_str)
                    host_str_list  = host_str.split(',')
                    #用__in来查询出主机信息
                    host_list += self.db_models.Host.objects.filter(hostname__in = host_str_list)

            if '-g' in self.sys_argvs:
                # -g +1  的索引位置的参数正好是主机名
                group_str_index = self.sys_argvs.index('-g') + 1
                print ('group_str_index',group_str_index)
                if len(self.sys_argvs) <= group_str_index:
                    exit('必须在组后面提供组参数')
                else:
                    #sys_argvs下标为5正好为主机组
                    group_str = self.sys_argvs[group_str_index]
                    print ('group_str',group_str)
                    group_str_list  = group_str.split(',')
                    #用__in来查询出主机信息
                    group_list = self.db_models.HostGroup.objects.filter(name__in=group_str_list)

                    print ('group list:',group_list)
                    for group  in group_list:
                        host_list += group.hosts.select_related()
            self.host_list = set(host_list)
            print ('host list:',host_list)
            return True

        else:
            exit('host [-h] or group [-g] argument must be provided')

    def syntax_parser(self,section_name,mod_name,mod_data,os_type):
        print("-going to parser state data:",section_name,mod_name)
        self.raw_cmds = []
        self.single_line_cmd = []
        for state_item in mod_data:
            print("\t",state_item)
            for key,val in state_item.items():
                # print ('key',key,'val',val)#key uid val 87或者有依赖关系 key require val (group: apache)
                #self就是state的module_instance实例,最后交给plugins下的单独函数处理
                if hasattr(self,key):
                    state_func = getattr(self,key)
                    state_func(val,section=section_name,os_type=os_type)
                else:
                    exit("Error:module [%s] has no argument [%s]" %( mod_name,key ))
        #没有break就执行else
        else:
            if '.' in mod_name:
                #mod_name = user.present
                base_mod_name,mod_action = mod_name.split('.')
                if hasattr(self,mod_action):
                    mod_action_func = getattr(self,mod_action)
                    #这里接收的User，group模块的函数可以接收*args，**kwargs
                    cmd_list = mod_action_func(section=section_name,mod_data=mod_data)  #present
                    data = {
                        'cmd_list':cmd_list,
                        'required_list':self.require_list,
                    }
                    if type(cmd_list) is dict:
                        data['file_module'] = True
                        data['sub_action'] = cmd_list.get('sub_action')
                    #上面代表一个section里的具体module已解析完毕
                    return data
                else:
                    exit("Error:module [%s] has no method [%s]" %(mod_name,mod_action))
            else:
                exit("Error:module action of [%s] must be supplied" %(mod_name))


#导入plugins下的文件，当模块导入
    def get_module_instance(self,*args,**kwargs):
        base_mod_name = kwargs.get('base_mod_name')
        os_type = kwargs.get('os_type')
        #plugin_file_path就是plugins目录下的py文件
        plugin_file_path = "%s/%s.py" % (self.settings.SALT_PLUGINS_DIR,base_mod_name)
        if os.path.isfile(plugin_file_path):

            #导入同级目录下的文件模块,base_mod_name上面解释过了
            #module_plugin <module 'plugins' from 'D:\\Python\\code\\day30\\Stark\\Arya\\plugins\\__init__.py'>
            module_plugin = __import__('plugins.%s' %base_mod_name)
            # print ('module_plugin',module_plugin)
            #特殊系统处理的模块，拼接起来就是WindowsUser...
            special_os_module_name = "%s%s" %(os_type.capitalize(),base_mod_name.capitalize())
            # print ('special_os_module_name',special_os_module_name)
            module_file= getattr(module_plugin, base_mod_name) # 这里才是真正导入模块
            if hasattr(module_file, special_os_module_name):
                #如果这些模块里面有特殊系统处理如UbuntuUser处理就调用这个方法
                module_instance = getattr(module_file, special_os_module_name)
            else:
                #就调用通用方法处理
                module_instance = getattr(module_file,base_mod_name.capitalize())
             #开始调用此module进行配置解析
            #这里的模块就是plugins下的user，group等，因为继承了BaseSaltModule，所以要传初始参数过去
            module_obj = module_instance(self.sys_argvs,self.db_models,self.settings)
            return module_obj
            #开始调用 此module 进行配置解析
        else:
            exit("module [%s] is not exist" % base_mod_name)

