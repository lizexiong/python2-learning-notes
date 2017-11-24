#!/usr/bin/env python
# -*- coding:utf-8 -*-
# Author:Alex Li
from Arya.backends.base_module import BaseSaltModule


class Group(BaseSaltModule):

    def gid(self,*args,**kwargs):
        cmd = "-g %s" %args[0]
        self.raw_cmds.append(cmd)


    def present(self,*args,**kwargs):
        # groupname = kwargs.get('section')
        #
        # cmd_list = ["groupadd %s" %groupname]
        # single_line_arguments = ['addusers',]
        # single_line_cmds = [] #需单独执行的命令
        # for state_item in kwargs.get("mod_data"):
        #     for state_func_name,val in state_item.items():
        #         state_func = getattr(self,state_func_name)
        #
        #         state_res = state_func(val,**kwargs)
        #         if state_res:#结果不为空
        #             if state_func_name in single_line_arguments:
        #                 single_line_cmds.append(state_res)
        #             else:
        #                 cmd_list.append(state_res)
        #
        # raw_cmds = [' '.join(cmd_list)] + single_line_cmds
        # #print('raw cmds:',raw_cmds)
        # #final_cmd
        # return raw_cmds
        cmd_list = []
        username = kwargs.get('section')
        self.raw_cmds.insert(0,"groupadd %s" %username)
        cmd_list.append(' '.join(self.raw_cmds))
        cmd_list.extend(self.single_line_cmd)
        return cmd_list
        print (cmd_list)

    def is_required(self,*args,**kwargs):
        print ('Checking user required',args,kwargs)
        name = args[1]
        cmd = '''more /etc/group | awk -F':' '{print $1}' | grep -w %s -q;echo $?''' %name
        return cmd