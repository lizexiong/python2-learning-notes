#!/usr/bin/env python
#--*-- coding:utf-8 --*--

import subprocess

ret=subprocess.check_call("dir",shell=True)
print ret.read()