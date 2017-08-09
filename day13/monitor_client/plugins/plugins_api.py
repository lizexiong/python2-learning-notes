#!/usr/bin/evn python
#--*-- coding:utf-8 --*--

import load,cpu

def get_load_info():
    return load.monitor()

def get_cpu_info():
    return cpu.monitor()

