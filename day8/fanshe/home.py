#!/usr/bin/env python
#--*-- coding:utf-8 --*--

def index():
    return "宿敌"

def dev():
    return "是劫是缘随我心，除了你万敌不侵"

class Foo():

    name = '李泽雄'
    def __init__(self):
        self.name='lizexiong'

    def show(self):
        pass

    @staticmethod
    def show_static():
        pass

    @classmethod
    def cls_show(cls):
        pass