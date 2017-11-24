# -*- coding: utf-8 -*-

import os,sys

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.append(BASE_DIR)

#这这里导入是一位内sys.path.append还没将环境变量加入进入
from core import main

if __name__ == "__main__":
    #把用户输入的sys.argv参数传入到下面的函数里面
    client = main.command_handler(sys.argv)

