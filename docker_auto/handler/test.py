# -*- coding: utf-8 -*-

from docker_auto.handler.node import NodeInfo,DataManage

def _getgroup():
    group_data = []
    group_set = NodeInfo.group_list()
    for i in DataManage.group_list(group_set):
        group_data.append(i)
    # node_data = NodeInfo.node_info()
    # node_data_handled = DataManage.manage_node_info(node_data)
    return group_data





        # node_data = NodeInfo.node_info()
        # node_data_handled = DataManage.manage_node_info(node_data)

l = _getgroup()
print (l)