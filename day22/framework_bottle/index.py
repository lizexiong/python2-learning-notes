#!/usr/bin/env python
# -*- coding:utf-8 -*-

from bottle import template, Bottle
root = Bottle()

@root.route('/hello/')
def index():
     # 默认情况下去目录：['./', './views/']中寻找模板文件 hello_template.html
    # 配置在 bottle.TEMPLATE_PATH 中
    return template('hello_template.html', name='lizexiong')

root.run(host='localhost',port=8080)






