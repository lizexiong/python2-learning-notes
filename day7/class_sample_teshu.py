#!/usr/bin/env python
#--*-- coding:utf-8 --*--


#1. __doc__ 表示类的描述信息
# class foo:
#     """描述类信息测试"""
#     def func(self):
#         pass
# print foo.__doc__

#2. __module__ 和  __class__ 　　__module__ 表示当前操作的对象在那个模块 ,__class__     表示当前操作的对象的类是什么
# class C:
#
#     def __init__(self):
#         self.name = 'wupeiqi'
#
#
# from lib.aa import C
#
# obj = C()
# print obj.__module__  # 输出 lib.aa，即：输出模块
# print obj.__class__      # 输出 lib.aa.C，即：输出类

#3.__init__ 　构造方法，通过类创建对象时，自动触发执行。

#4. __del__
"""
析构方法，当对象在内存中被释放时，自动触发执行。
注：此方法一般无须定义，因为Python是一门高级语言，程序员在使用时无需关心内存的分配和释放，因为此工作都是交给Python解释器来执行，所以，析构函数的调用是由解释器在进行垃圾回收时自动触发执行的。
"""

#5__call__
"""
# 对象后面加括号，触发执行。
# 注：构造方法的执行是由创建对象触发的，即：对象 = 类名() ；而对于 __call__ 方法的执行是由对象后加括号触发的，即：对象() 或者 类()()
# """
# class Foo:
#
#     def __init__(self):
#         pass
#
#     def __call__(self, *args, **kwargs):
#
#         print '__call__'
#
#
# obj = Foo() # 执行 __init__
# obj()    # 执行 __call__

#6.__dict__
"""
类或对象中的所有成员
上文中我们知道：类的普通字段属于对象；类中的静态字段和方法等属于类，即：
"""
class Province:

    country = 'China'

    def __init__(self, name, count):
        self.name = name
        self.count = count

    def func(self, *args, **kwargs):
        print 'func'

# 获取类的成员，即：静态字段、方法、
print Province.__dict__
# 输出：{'country': 'China', '__module__': '__main__', 'func': <function func at 0x10be30f50>, '__init__': <function __init__ at 0x10be30ed8>, '__doc__': None}

obj1 = Province('HeBei',10000)
print obj1.__dict__
# 获取 对象obj1 的成员
# 输出：{'count': 10000, 'name': 'HeBei'}

obj2 = Province('HeNan', 3888)
print obj2.__dict__
# 获取 对象obj1 的成员
# 输出：{'count': 3888, 'name': 'HeNan'}

