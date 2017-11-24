#!/usr/bin/env python
# -*- coding:utf-8 -*-
# Author:Alex Li
from Arya.backends.base_module import BaseSaltModule


class Pkg(BaseSaltModule):

    pass


    def is_required(self,*args,**kwargs):
        return "echo 0"
