#!/usr/bin/env python
#--*-- coding:utf-8 --*--


import os,sys
Base_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.append(Base_dir)
from  modules import main


if __name__ == "__main__":
    EntryPoint = main.ArgvHandler(sys.argv)