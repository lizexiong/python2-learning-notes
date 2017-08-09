#!/usr/bin/env python
#--*-- coding:utf-8 --*--

class Animal:
    def eat(self):
        print "%s 吃" %self.name

    def drink(self):
        print "%s 喝" %self.name

    def shit(self):
        print "%s 拉" %self.name

class cat(Animal):
    def __init__(self,name):
        self.name = name
        self.breed = '猫'

    def eat(self):
#优先使用自己的
        print "eat"

    def cry(self):
        print "喵喵叫"

class dog(Animal):
    def __init__(self,name):
        self.name= name
        self.breed ="狗"

    def cry(self):
        print "汪汪叫"

c1=cat('小白家的小白猫')
c1.eat()

c2=cat('小黑家的小黑猫')
c2.drink()

c3=dog("小蓝家的小母狗")
c3.shit()

c3.