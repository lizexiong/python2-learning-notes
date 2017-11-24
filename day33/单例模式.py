# -*- coding: utf-8 -*-

#实现__new__方法
#并在将一个类的实例绑定到类变量_instance上,
#如果cls._instance为None说明该类还没有实例化过,实例化该类,并返回
#如果cls._instance不为None,直接返回cls._instance


class Singleton(object):
    def __new__(cls, *args, **kwargs):
        if not hasattr(cls,'_instance'):
            orig = super(Singleton,cls)
            cls._instance = orig.__new__(cls)
        return cls._instance

class MyClass(Singleton):
    def __init__(self,name):
        self.name = name

a = MyClass("Alex")
print (id(a.name))
b = MyClass("Jack")

print (id(a.name))
print (id(b.name))



'''
    class Singleton(object):
      def __new__(cls,*args,**kwargs):
        if not hasattr(cls,'_inst'):
          cls._inst=super(Singleton,cls).__new__(cls,*args,**kwargs)
        return cls._inst
    if __name__=='__main__':
      class A(Singleton):
        def __init__(self,s):
          self.s=s
      a=A('apple')
      b=A('banana')
      print id(a),a.s
      print id(b),b.s
    结果：
    29922256 banana
    29922256 banana
    通过__new__方法，将类的实例在创建的时候绑定到类属性_inst上。如果cls._inst为None，
    说明类还未实例化，实例化并将实例绑定到cls._inst，以后每次实例化的时候都返回第一次实例化创建的实例。
    注意从Singleton派生子类的时候，不要重载__new__。

    以上意思简单就是，除了第一次使用初始一个实例，以后都用这个实例，在这个第一次的实例里面操作，所以结果每次都是最后一个传入的参数
    对象是类通过实例化得出的一个具体的个体 ，实例化就是从类到个体的过程。
    '''