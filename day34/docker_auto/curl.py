# -*- coding: utf-8 -*-

import os
import pycurl
import json
from io import BytesIO

class Curl(object):
    def __init__(self,curl):
        self.__curl__ = curl

    def get_value(self):
        d_url = pycurl.Curl()   #创建一个同libcurl中的CURL处理器相对应的Curl对象
        url_buf = BytesIO()
        d_url.setopt(d_url.URL, self.__curl__)  #设置要访问的网址

        try:
            d_url.setopt(d_url.WRITEFUNCTION, url_buf.write) #写的回调
            d_url.perform()                             #执行上述访问网址的操作
        except pycurl.error as error:                   #该错误处理只有在大于400才会正常执行
            errno ,errstr = error
            print('An error occurred: ', errstr)
        ret_json = json.loads(url_buf.getvalue().decode())      #反正就是这么写，获取返回的html内容
        # d_url.close()
        # url_buf.close()
        return ret_json

    def post_value(self, action, param):
        pass