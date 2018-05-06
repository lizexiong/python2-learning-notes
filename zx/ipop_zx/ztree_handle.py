# -*- coding: utf-8 -*-

#ztree异步加载返回给前端数据处理
def group_handle(result):
    group_data = []
    for line in result:
        tmp_dic = {}
        # print (line['group'])   #取出数据库的组
        tmp_dic['id'] = str(line['group'])
        tmp_dic['name'] = line['group']
        tmp_dic['isParent'] = "true"
        tmp_dic['target'] = "RightFrame"
        tmp_dic['url'] = "ipop_zx/group/?group=" + line['group']
        #去重,如果有多个主机组名称相同,那么只显示一个
        if tmp_dic not in group_data:
            group_data.append(tmp_dic)
    # print (group_data,'=============')
    return group_data

def network_handle(result,group):
    network_data = []
    for line in result:
        tmp_dic = {}
        tmp_dic['name'] = line['network']
        tmp_dic['isParent'] = 'false'
        tmp_dic['target'] = "RightFrame"
        tmp_dic['url'] = "ipop_zx/network/?network=" + line['network'] + "&&group=" + group
        if tmp_dic not in network_data:
            network_data.append(tmp_dic)
    return network_data
