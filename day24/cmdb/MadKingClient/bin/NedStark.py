#_*_coding:utf-8_*_
__author__ = 'Alex Li'
import os,sys,platform

#for linux
if platform.system() == "Windows":
    #获取脚本运行的上一级路径
    BASE_DIR = '\\'.join(os.path.abspath(os.path.dirname(__file__)).split('\\')[:-1])
    print BASE_DIR
else:
    BASE_DIR = '/'.join(os.path.abspath(os.path.dirname(__file__)).split('/')[:-1])
#把获取的路径加入进去，因为这里有很多我们自己写的模块要导入
sys.path.append(BASE_DIR)

from core import HouseStark


if __name__ == '__main__':

    HouseStark.ArgvHandler(sys.argv)