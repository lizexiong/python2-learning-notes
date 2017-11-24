# -*- coding: utf-8 -*-

import os,sys

if __name__ == "__main__":
    #设置一个系统的环境变量
    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "Stark.settings")
    BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    #print(BASE_DIR)
    sys.path.append(BASE_DIR)
    from Arya.action_list import actions
    from Arya.backends.utils import ArgvManagement
    obj = ArgvManagement(sys.argv)