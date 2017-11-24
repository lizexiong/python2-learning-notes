# -*- coding: utf-8 -*-

import random

#冒泡,每两个相近的值做对比,每次比相邻的两个值

def bubbling(array):
    #1.比如数组长度为10，那么循环10次
    for i in range(len(array)):
        #2.里面的循环从i开始，第一次是下标array[0]的值

        #5.进入第二次循环,i为1 ，那么j就是1，  那么对比的就是array[1] 和array[1+1]对比，以此类推
        for j in range(i,len(array)):
            #3.下标array[0]和array[0+1]的值，比较，如果下标0的值大，那么调换位置,把大的值放在后面
            #4.第二个内层循环 array[1]和array[2]在比较,在把大的值放到后面
            if array[j] > array[j+1]:
                temp = array[j]
                array[j] = array[j+1]
                array[j+1] = temp


if __name__ == "__main__":
    array = []
    for i in range(10):
        array.append(random.randrange(1000))
        bubbling(array)
        print array