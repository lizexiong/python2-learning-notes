#!/usr/bin/env python
# -*- coding:utf-8 -*-
from bottle import template, Bottle

web02_obj = Bottle()


@web02_obj.route('/hello/', method='GET')
def index():
    return template("<b>web02_obj {{name}}</b>!",name='web02')