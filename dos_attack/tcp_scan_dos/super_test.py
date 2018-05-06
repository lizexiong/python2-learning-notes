#!/usr/bin/python3
#--*-- coding:utf-8 --*



class A(object):
	def __init__(self):
		print ('A')

	def test_a(self):
		print ('test_a')

class B(A):
	def __init__(self):
		print ('B')

	def test_b(self,):
		print ('test_b')


class C(B):
	def __init__(self):
		super(C,self).__init__()

	def test_C(self):
		print ('test_c')



obj = C()
obj.test_a()
