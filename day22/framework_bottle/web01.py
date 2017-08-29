#!/usr/bin/env python
# -*- coding:utf-8 -*-
from bottle import template, Bottle

web01_obj = Bottle()

@web01_obj.route('/hello/', method='GET')
def index():
    return template("<b>web01_obj {{name}}</b>!",name='web01')
