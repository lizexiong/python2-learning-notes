# -*- coding: utf-8 -*-


import models
from django.core.exceptions import  ObjectDoesNotExist

class ClientHandler(object):

    #初始化里面将client_id和client_configs封装在里面
    def __init__(self,client_id):
        self.client_id = client_id
        self.client_configs = {
            "services":{}
        }

    def fetch_configs(self):
        try:
            #通过get方式取出数据库的主机记录，出去结果为<Host: centos>
            host_obj = models.Host.objects.get(id=self.client_id)
            '''
            取出该主机有哪些模版，因为templates是多对多关联,所以要使用优化select_related来取出具体值，
            格式为:<QuerySet [<Template: LinuxGenericServices>]>
            以上结果看试为列表，其实全名叫搜索的结果集
           '''
            template_list = list(host_obj.templates.select_related())
            '''
            因为主机可以属于主机组，所以这里还要把主机组的模版也取出来，模版可能会重复，但是没有关系,（因为字典相同的key会自动覆盖）
            下面的格式是列表里面包含的对象。
            格式为:[<Template: LinuxGenericServices>, <Template: LinuxGenericServices>, <Template:LinuxCpu>]
          '''
            for host_group in host_obj.host_groups.select_related():
                #然后把主机组的模版给添加进入template_list里面
                template_list.extend(host_group.templates.select_related())
            print template_list
            '''
            由于[<Template: LinuxGenericServices>, <Template: LinuxGenericServices>, <Template:LinuxCpu>]是对象
            那么就可以取出模版下面有哪些监控服务
          '''
            for template in template_list:
                for service in template.services.select_related():
                    #在把服务名，服务插件名，监控服务执行的间隔时候放入字典
                    self.client_configs['services'][service.name] = [service.plugin_name,service.interval]

        except ObjectDoesNotExist:
            pass

        return self.client_configs



#触发报警用的函数,通过输入的主机对象，来判断这个主机和主机所属组下有哪些trigger，并返回。
def get_host_triggers(host_obj):
    triggers = []
    for template in host_obj.templates.select_related():
        #这里注意append和extend的区别
        triggers.extend(template.triggers.select_related())
    for group in host_obj.host_groups.select_related():
        for template in group.templates.select_related():
            triggers.extend(template.triggers.select_related())
    return set(triggers)