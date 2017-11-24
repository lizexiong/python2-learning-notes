# -*- coding: utf-8 -*-

'''
        本章桥接模式理论不在讲解,先把本章类继承关系列出
        AbstractRoad()  Street(AbstractRoad)  SpeedWay(AbstractRoad)
        AbstractCar()   Car(AbstractCar)     Bus(AbstractCar)
        People()        Man(People)        WoMan(People)
        本章类的关系并不复杂，复杂的是各种类里面方法赋值之后的调用方式

        AbstractRoad   car = None
        AbstractCar    def run(self)
        People

        Speedway        def run(self):
                        self.car.run()
        Car           def run(self):
        Man           def drive(self):
                        print ("男人开着")
                        self.road.run()

        查看调用方式和顺序
            road = SpeedWay()     实例化对象高速公路这个对象
            road.car = Car()      实例化Car这个类复制给高速公路的car，相当于把什么车的对象封装到了高速公路里面

            p = Man()             实例化Man 对象
            p.road = road        把高速公路封装的对象 在封装到男人这个类里面
            p.drive()             然后这里面有self.road.run() ，经过上面的封装，执行self.road.run等于 SpeedWay的 run方法
'''


class AbstractRoad(object):
    ''' 公路基类'''
    car = None

class AbstractCar(object):
    '''车辆基类'''

    def run(self):
        pass

class People(object):
    pass

class Street(AbstractRoad):
    '''市区街道'''

    def run(self):
        self.car.run()
        print("在市区街道上行驶")

class SpeedWay(AbstractRoad):
    '''高速公路'''

    def run(self):
        self.car.run()
        print("在高速公路上行驶")

class Car(AbstractCar):
    '''小汽车'''
    def run(self):
        print ('小汽车在')

class Bus(AbstractCar):

    def run(self):
        print ('公共汽车在')


class Man(People):
    def drive(self):
        print ("男人开着")
        self.road.run()

class WoMan(People):
    def drive(self):
        print ('女人开着')
        self.road.run()

if __name__ == '__main__':
    road = SpeedWay()
    road.car = Car()

    p = Man()
    p.road = road
    p.drive()






# class AbstractRoad(object):
#     '''公路基类'''
#     car = None
#
# class AbstractCar(object):
#     '''车辆基类'''
#
#     def run(self):
#         pass
#
# class Street(AbstractRoad):
#     '''市区街道'''
#
#     def run(self):
#         self.car.run1()
#         print("在市区街道上行驶")
#
# class SpeedWay(AbstractRoad):
#     '''高速公路'''
#
#     def run(self):
#         self.car.run()
#         print("在高速公路上行驶")
#
#
# class Car(AbstractCar):
#     '''小汽车'''
#     def run1(self):
#         print("小汽车在")
#
# class Bus(AbstractCar):
#     '''公共汽车'''
#     def run(self):
#         print("公共汽车在")
#
#
# if __name__ == "__main__":
#     #小汽车在高速上行驶
#     road1 = SpeedWay()
#     road1.car = Bus()
#     road1.run()
#
#     #
#     road2 = Street()
#     road2.car = Car()
#     road2.run()
