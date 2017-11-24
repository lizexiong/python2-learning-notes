# -*- coding: utf-8 -*-

import os,sys

if __name__=="__main__":
    #这里和django的书写方式一样
    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "CrazyMonitor.settings")
    from monitor.backends.management import execute_from_command_line

    execute_from_command_line(sys.argv)