# -*- coding: utf-8 -*-

'''
优点：客户端不需要修改代码。
缺点： 当需要增加新的运算类的时候，不仅需新加运算类，还要修改工厂类，违反了开闭原则
'''

class ShapeFactory(object):

    def getShape(self):
        return self.shape_name

class Circle(ShapeFactory):

    def __init__(self):
        self.shape_name = "Circle"

    def draw(self):
        print ("draw Circle")

class Rectangle(ShapeFactory):

    def __init__(self):
        self.shape_name = "Rectangle"

    def draw(self):
        print ('draw Fectangle')


class Shape(object):

    def create(self,shape):
        if shape == "Circle":
            return Circle()
        elif  shape == "Rectangle":
            return Rectangle()
        else:
            return None


obj1 = Shape()
obj1 = obj1.create('Circle')
obj1.draw()

