# -*- coding: utf-8 -*-

# from handler.node import NodeInfo,DataManage
#
# def _getgroup():
#     group_data = []
#     group_set = NodeInfo.group_list()
#     for i in DataManage.group_list(group_set):
#         group_data.append(i)
#     # node_data = NodeInfo.node_info()
#     # node_data_handled = DataManage.manage_node_info(node_data)
#     return group_data
#
#
#
#
#
#         # node_data = NodeInfo.node_info()
#         # node_data_handled = DataManage.manage_node_info(node_data)
#
# l = _getgroup()
# print (l)

# from handler.node import online_check
#
# test = online_check("trigger_update_node")

# import queue
# q = queue.Queue()
# if q.empty():
#     for i in range(1030,1050):
#         q.put(i)
# else:
#     pass
#
# #首先把已经用过的端口号拿出来
# out_to_int = []
# for i in range(5):
#      out_to_int.append(q.get(i))
# print (out_to_int)
# #即将要分配的端口号
# out=[]
# for i in range(5):
#      out.append(q.get(i))
#
# for i in range(len(out_to_int)):
#     q.put(out_to_int[i])
#
# while not q.empty():
#     print (q.get())

# import queue
# class port_allot(object):
#
#     def __init__(self):
#         pass
#
#     def initial_name(self,name):
#         self.key_name = 'q_' + name
#         return self.key_name
#
#     def initial_put(self):
#         self.initial_name = queue.Queue()
#         for i in range(2000,3000):
#             self.key_name.put(i)
#
#     def put_q(self,value=None):
#         q = self.key_name.put(value)
#
#     def get_q(self,value=None):
#         q = self.key_name.get(value)
#         return q



#
# from myswarm import Myswarm
# obj = Myswarm()
# port_list = []
# con_list = obj.container_list('192.168.100.200','2375',all)
# print (con_list)
# for port_key in con_list.values():
#      port_dict = port_key['port']
#      print (port_dict)
#      for cport in port_dict.values():
#          for i in cport:
#              port_list.append(i['HostPort'])
# print (port_list)


from model.node import NodeInfo

for i in range(1000):
    import random
    con_id = str(random.randint(100000222220,23323232333333))
    NodeInfo.insert_con_usage(con_id,"192.168.1."+str(i),"192.168.1."+str(i))
