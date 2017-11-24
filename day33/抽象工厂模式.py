# -*- coding: utf-8 -*-

'''
    抽象工厂比工厂模式区别在于，如果是装机的情况下，就不能让用户自主全部选择不配套的硬件，相当与intel生产intel的东西
    下面是类继承关系对应
    AbstractFactory()
        IntelFactory(AbstractFactory)      return IntelCpu
        AmdFactory(AbstractFactory)        return AmdCpu

    AbstractCpu()
        IntelCpu(AbstractCpu)
        AmdCpu(AbstractCpu)
    AbstractMainboard()
        IntelMainBoard(AbstractMainboard)
        AmdMainBoard(AbstractMainboard)

'''


class AbstractFactory(object):
    computer_name = ''
    def createCpu(self):
        pass
    def createMainboard(self):
        pass


class IntelFactory(AbstractFactory):
    computer_name = 'Intel I7 computer'
    def createCpu(self):
        return IntelCpu('I7-6000')
    def createMainboard(self):
        return IntelMainBoard('Intel-6000')

class AmdFactory(AbstractFactory):
    computer_name = 'Amd 4 computer'

    def createCpu(self):
        return AmdCpu('amd444')
    def createMainboard(self):
        return AmdMainBoard('AMD-4000')

class AbstractCpu(object):
    series_name =   ''
    instructions = ''
    arch = ''

class IntelCpu(AbstractCpu):
    def __init__(self,series):
        self.series_name = series

class AmdCpu(AbstractCpu):
    def __init__(self,series):
        self.series_name = series

class AbstractMainboard(object):
    series_name = ''

class IntelMainBoard(AbstractMainboard):
    def __init__(self,series):
        self.series_name = series

class AmdMainBoard(AbstractMainboard):
    def __init__(self,series):
        self.series_name = series


class ComputerEngineer(object):

    def makeComputer(self,computer_obj):
        self.prepareHandwares(computer_obj)

    def prepareHandwares(self,computer_obj):
        self.cpu = computer_obj.createCpu()
        self.mainboard = computer_obj.createMainboard()

        info = '''------- computer [%s] info:
    cpu: %s
    mainboard: %s

 -------- End --------
        '''% (computer_obj.computer_name,self.cpu.series_name,self.mainboard.series_name)
        print(info)

if __name__ == "__main__":
    engineer = ComputerEngineer()

    computer_factory = IntelFactory()
    engineer.makeComputer(computer_factory)




