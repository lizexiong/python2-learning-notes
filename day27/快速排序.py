# -*- coding: utf-8 -*-

import random


def quick_sort(array,start,end):
    #到这里之后，start 不可能大于end，当== 的时候，代表他们已经是最近的2个值了。
    if start >= end:
        return
    k = array[start]
    left_flag = start
    right_flag = end

    #从右边开始比较
        #如果左边的值比right小,才开始循环
    while left_flag < right_flag:
        #下面的while继续往左边移动小旗子.
        while left_flag < right_flag and array[right_flag] > k:
            #每移动一次就减一
            right_flag -= 1
        temp = array[left_flag]
        array[left_flag] = array[right_flag]
        array[right_flag] = temp


    #从右边开始比较
        while  left_flag < right_flag and array[left_flag] <= k:
            left_flag += 1
        temp = array[left_flag]
        array[left_flag] =array[right_flag]
        array[right_flag] = temp

    #把左边已经比较好的值递归给自己
    #left_flag-1 为边界有时候2边的值的数量并不是相等分的。
    quick_sort(array,start,left_flag-1)
    #把右边已经比较好的值递归给自己
    quick_sort(array,left_flag+1,end)

if __name__ == "__main__":
    # array = [86, 29, 86, 47, 96, 75, 3, 21, 16, 58]
    array = []
    for i in range(10):
        array.append(random.randrange(100))

    quick_sort(array,0,len(array)-1)
    print array