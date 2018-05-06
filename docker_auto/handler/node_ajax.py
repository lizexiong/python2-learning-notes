# -*- coding: utf-8 -*-

from .base import BaseHandler
import json
from myswarm import Myswarm
from myswarm import online_check
from model.node import NodeInfo
from model.data_manage import DataManage,DataManageAjax

class NodeManageHostStatus(BaseHandler):
    def get(self,*args, **kwargs):
        #加载界面之前，更新节点状态
        node_status_check = online_check()
        node_status_check.trigger()

        node_data = NodeInfo.node_info(status=None)
        node_data_handled = DataManageAjax.status_list(node_data)
        print (node_data_handled)
        self.write(json.dumps(node_data_handled))


#准备联合datatable后台分页做的,因为失败,废弃
# class pag(BaseHandler):
#     def get(self,*args,**kwargs):
#         data = self.get_argument('aodata')
#         data= json.loads(data)
#         print (data)
#         for i in data:
#             if i['name'] == "sEcho":
#                 sEcho = i['value']
#             elif i['name'] == "iDisplayStart":
#                 iDisplayStart = i['value']
#             elif i['name'] == "iDisplayLength":
#                 iDisplayLength = i['value']
#         node_info = NodeInfo.node_info(status=all)
#
#         # node_info = [{'id':1,'name':2,'age':3,'con':4}]
#         data = {
#             "draw": 1,
#             "recordsTotal": 57,
#             "recordsFiltered": 57,
#             "data": [[1,2,3]]
#         }
#
#         self.write(json.dumps(data))