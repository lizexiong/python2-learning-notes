#--*-- coding:utf-8 --*--

data = [
    (None,'A'),
    ('A5','A6'),
    ('A','A1'),
    ('A',"A1-1"),
    ('A1',"A2"),
    ('A1-1',"A2-3"),
    ('A2-3','A3-4'),
    ('A1','A2-2'),
    ('A2','A3'),
    ('A2-2','A3-3'),
    ('A3','A4'),
    (None,'B'),
    ('B','B1'),
    ('B1','B2'),
    ('B1','B2-2'),
    ('B2','B3'),
    (None,'C'),
    ('C','C1'),
]

def tree_search(d_dic,parent,son):
    #4.开始循环传入的字典，i 为 键，也就是父亲，j为值，为就是儿子
    #此时字典就是传入进来的字典ata_dic= {'A':{}}
    for i,j in d_dic.items():
        """
        5. 此时i为A ，j为空，那么列表下标为1的数据过来，就是   ('A','A1'),
        name i=A == A=parent,
        那么我也不是顶级评论了，那么就要生成 d_dic['A']['A1'] = {},把自己加到自己爹下面。
        这时候就要返回空，退出这次循环,因为已经找到，没有必要在找了，数据已经存在字典了

        此时，比如字典A评论就就是深度查询，重头找到底
        """

        if i == parent:
            d_dic[i][son] ={}
            return
        else:
            """
        6.如果i 不等于父亲，那么就是第一层没有找到，那么就往一下层找，把d_dic[i]，传进入，如果传入d_dic,
        那么就是死循环了
        这里d_dic[i]本人也想了很久，这是 d_dic['A']，那么传入的就是第二层字典了。然后再次回到第5步。
        然后第三次循环这里的d_dic[i]就等于d_dic['A']//['A1'] = {}
        //代表传入的时候d_dic[A]已经是取出来的值了，只是往更深层去找了
        思路有点复杂，以上才是重点思路
            """
            tree_search(d_dic[i],parent,son)

data_dic = {}

for i in data:
    #1.取出列表的的两个值，左边为父亲，右边为儿子
    parent,son = i
    # print parent,'-----',son
    #2.如果父亲为空，那么自己就是顶级，那么生成字典，自己为最顶级，没有父亲，所以是data_dic[son]
    #此时字典为 data_dic= {'A':{}}
    if parent is None:
        data_dic[son] = {}
    #3.否则，进入另一个判断函数，那么就要把自己传入进入，把自己的爹传入进去，son就是自己
    else:
        tree_search(data_dic,parent,son)

print data_dic

