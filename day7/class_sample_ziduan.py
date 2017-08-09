#!/usr/bin/env python
#--*-- coding:utf-8 --*--



#==========================>字段
# class province:
#     country = "china"
#     def __init__(self,name):
#         self.name=name
#
# obj = province("上海市")
#
# print obj.name
#
# #直接访问静态字段
# print province.country



#==========================>方法
class foo:

    def __init__(self,name):
        self.name = name

    def ord_func(self):
        #定义普通方法，至少一个self参数
        print "普通方法"

    @classmethod
    def class_func(cls):
        #定义类方法，至少一个cls参数
        print "类方法"

    @staticmethod
    def static_func(a,b):
        #定义静态方法，无需默认参数
        print "静态方法,",a,b

#调用普通方法
obj =foo('lizexiong')
obj.ord_func()

#调用类方法
foo.class_func()

#使用静态方法
foo.static_func(66,88)


#===========================属性

# class foo:
#
#     def func(self):
#         pass
#
#     @property
#     def prop(self):
#         print "属性"
#
# #调用属性
# obj = foo()
# obj.prop


#属性的基本使用
"""
实例：对于主机列表页面，每次请求不可能把数据库中的所有内容都显示到页面上，而是通过分页的功能局部显示，所以在向数据库中请求数据时就要显示的指定获取从第m条到第n条的所有数据（即：limit m,n），这个分页的功能包括：
根据用户请求的当前页和总数据条数计算出 m 和 n
根据m 和 n 去数据库中请求数据
"""
# class Pager:
#     def __init__(self,current_page):
#         #用户请求的页码(第一页，第二页)
#         self.current_page = current_page
#         self.per_items =10
#
#     @property
#     def start(self):
#         val = (self.current_page-1) * self.per_items
#         return val
#
#     @property
#     def end(self):
#         val = self.current_page * self.per_items
#         return val
#
# P = Pager(2)
# print P.start
# print P.end

#属性的两种定义方式
# 经典类，具有一种@property装饰器，新式类，具有三种@property装饰器
#经典类不在做演示，以下定义新式类
# class Goods(object):
#     @property
#     def price(self):
#         print "@property"
#
#     @price.setter
#     def price(self,value):
#         print "@price.setter"
#
#     @price.deleter
#     def price(self):
#         print "@price.deleter"
#
# obj = Goods
# obj.price #自动执行@property修饰的price方法，并获取方法的返回值
# obj.price = 88 #自动执行@price.setter修饰的方法,并将值88赋值给该方法的参数
# del obj.price #自动执行@price_deleter修饰的price方法

#由于新式类中具有三种访问方式，我们可以根据他们几个属性的访问特点，分别将三个方法定义为对同一个属性：获取、修改、删除
#此种方式使用的是静态字段
class Goods(object):
    def __init__(self):
        #原价
        self.original_price=10
        #折扣
        self.discount = 0.8

    def get_price(self):
        #实际价格= 原价* 折扣
        new_price = self.original_price * self.discount
        return new_price

    def set_price(self,value):
        self.original_price = value

    def del_price(self,value):
        del self.original_price

    PRICE=property(get_price,set_price,del_price,'价格属性描述.....')
obj=Goods()
obj.PRICE  #获取商品的原价
obj.PRICE = 88      #传入商品原价
print obj.PRICE
#del obj.PRICE        #删除商品原价


