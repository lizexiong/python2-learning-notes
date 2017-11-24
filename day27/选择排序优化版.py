# -*- coding: utf-8 -*-


import random

#选择排序优化版,记住最大或者最小值的下标,但是值只在外层循环结束后更改


def selection_sort(array):
     #1.比如数组长度为10，那么循环10次
    for i in range(len(array)):
        #2.把下标和循环的值生成一个变量
        small_index = i
        for j in range(i+1,len(array)):
            #3.如果 array[small_index](第一次循环等于array[i]) 大于 array[j](第一次循环等于array[i+1])
            if array[small_index] > array[j]:
                #4.那么将 small_index设置为j,那么这是array[small_index] = array[j],那么存储的就是最小的值
                #第二次内层循环进来,那么直接与这个最小值做对比,但是不更改值
                small_index = j
        #5.第一个大循环结束之后,array[small_index]存储的就是最小值的下标了,那么再将最小值给array[i]，也就是初始循环的下标
        temp = array[small_index]
        array[small_index] = array[i]
        array[i] = temp

if __name__ == "__main__":
    array = []
    for i in range(5):
        array.append(random.randrange(1000))

    selection_sort(array)
    print array
