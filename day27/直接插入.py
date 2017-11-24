# -*- coding: utf-8 -*-


import random

"""
    直接插入
    比如一个列表[11,33,22,44]
    加入22，那么22往左边开始比较，如果22比左边小,那么把该下标的值和前面一个下标更换，
    然后一直往左边比较,直到等于0就停止循环，然后把之前存储好的第一个初始值,赋值给已经改变的
    array[position],这时,array[position]已经在靠近边界最小的位置了,然后把原来的值 current_val放在这里
    就可以了,
    array[position] = array[position-1]
    上面的概念很容易搞混，因为第一感觉是array[position]是个值，但是这里先是下标,调换的是下标的位置，一定要记住,
    把下标的位置调换了
"""


def insertion(array):
    #1.循环列表的总长度
    for i in range(len(array)):
        #2.把i定义成为一个变量，因为i这个值等会需要改变，但是不是因为循环而改变。
        position = i
        #3.记录循环i的起始值，也就是要插入比较的第一个初始值，让他在这一次循环里面固定，current_val 虽然和 array[i]结果一样
        #但是性质不一样了，current_val是一个固定的值，而array[i]是一个数组，通过下标才能取值。
        current_val = array[i]
        #4. 如果position 小于0,或者当前的值不比左右小了，那么就不在循环了
        while position > 0 and current_val < array[position-1]:
            """
            5.这里也是最饶的，首先   array[position-1]是 postion左边的值,因为发现左边的值比我小了，
            那么把左边的下标和值赋值给我,这里position 就发生了改变，所以在while要记录一个初始值
            """
            array[position] = array[position-1]
            #6.每循环一次,position -1 ，到0了停止。
            position -= 1

        """
        7.while循环接收后,position 下标和值也应该到了最小的位置了，然后把刚记录的下标和值赋值过来就可以了
        """
        array[position] = current_val
        print array[position]


if __name__ == "__main__":
    array = []
    for i in range(5):
        array.append(random.randrange(100))
    print array
    insertion(array)
    print array


