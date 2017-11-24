# -*- coding: utf-8 -*-

import random


#选择排序,每个数和第一个数比较，如果第一个数大，那么就调换位置,

def selection_sort(array):
     #1.比如数组长度为10，那么循环10次
    for i in range(0,len(array)):
        #2. 让内层循环的数比外层要比较的i多个1，那么就是下标为0和1的值开始比较
        for j in range(i+1,len(array)):
            #3.如果array[0]> array[1] ,那么调换位置
            #4.第二次内层循环，如果 array[0] > array[2]，那么在挑换位置，第一个外层循环结束后，那么第一个最小的数就出来了
            if array[i] > array[j]:
                temp = array[i]
                array[i] = array[j]
                array[j] = temp

if __name__ == "__main__":
    array = []

    for i in range(10):
        array.append(random.randrange(1000))
    print array
    selection_sort(array)
    print array