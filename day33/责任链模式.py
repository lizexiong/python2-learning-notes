# -*- coding: utf-8 -*-



class BaseHandler(object):
    '''处理基类'''


    def successor(self,successor):
        #与下一个责任者关联
        self._successor = successor

class RequestHandlerL1(BaseHandler):
    '''第一次请求处理者'''
    name = 'Teamleader'
    def handle(self,request):
        if request < 500:
            print("审批者[%s],请求金额[%s],审批结果[审批通过]"%(self.name,request))
        else:
            print("\033[31;1m[%s]无权审批,交给下一个审批者\033[0m" %self.name)
            self._successor.handle(request)

class RequestHandlerL2(BaseHandler):
    '''第二级请求处理者'''
    name = "DeptManager"
    def handle(self,request):
        if request < 5000 :
            print("审批者[%s],请求金额[%s],审批结果[审批通过]"%(self.name,request))
        else:
            print("\033[31;1m[%s]无权审批,交给下一个审批者\033[0m" %self.name)
            self._successor.handle(request)

class RequestHandlerL3(BaseHandler):
    '''第三级请求处理者'''
    name = "CEO"
    def handle(self,request):
        if request < 10000 :
            print("审批者[%s],请求金额[%s],审批结果[审批通过]"%(self.name,request))
        else:
            print("\033[31;1m[%s]要太多钱了,不批\033[0m"%self.name)
            #self._successor.handle(request)


class RequestAPI(object):
    h1 = RequestHandlerL1()
    h2 = RequestHandlerL2()
    h3 = RequestHandlerL3()

    h1.successor(h2)
    h2.successor(h3)
    def __init__(self,name,amount):
        self.name = name
        self.amount = amount

    def handle(self):
        '''统一请求接口'''
        self.h1.handle(self.amount)

if __name__ == "__main__":
    r1 = RequestAPI("Alex",30000)
    r1.handle()
    print(r1.__dict__)