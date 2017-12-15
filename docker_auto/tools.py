# -*- coding: utf-8 -*-

def OnlyCharNum(s,oth=''):
    s2 = s.lower();
    fomart = 'abcdefghijklmnopqrstuvwxyz0123456789,'
    for c in s2:
        if not c in fomart:
            s = s.replace(c,'');
    return s;

import queue
class port_allot(object):

    def __init__(self,name):
        key_name = "q_" + name
        self.key_name = key_name
        self.key_name = queue.Queue()
        self.initial_put()

    def initial_put(self):
        self.key_name = queue.Queue()
        for i in range(2045,2100):
            self.key_name.put(i)

    def put_q(self,value=None):
        q = self.key_name.put(value)

    def get_q(self,value=None):
        q = self.key_name.get(value)
        return q




