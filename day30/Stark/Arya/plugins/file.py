#!/usr/bin/env python
# -*- coding:utf-8 -*-
# Author:Alex Li
from Arya.backends.base_module import BaseSaltModule


class File(BaseSaltModule):

    pass
    def is_required(self,*args,**kwargs):
        file_path = args[1]
        cmd = "test -f %s;echo $?" %file_path
        return cmd

    def managed(self,*args,**kwargs):
        kwargs['sub_action'] = "managed"
        return kwargs

    def source(self,*args,**kwargs):
        pass

    def user(self,*args,**kwargs):
        pass

    def group(self,*args,**kwargs):
        pass

    def mode(self,*args,**kwargs):
        pass