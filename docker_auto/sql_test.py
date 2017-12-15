# -*- coding: utf-8 -*-

# from model.node import NodeInfo
# from settings import DATABASES
#
#
# print (NodeInfo.node_modify('192.168.100.200'))

# def test(*args,**kwargs):
#      fuck = kwargs['test_dict'].get('fuck','None')
#      name = kwargs['test_dict'].get('name','None')
#      print (fuck,name)
#
# test_dict = {
#     "name":'lizexiong',
#     'age':'25',
# }
#
# test(test_dict=test_dict)


# import docker
# def create_container(self, node_ip, node_port, conf):
#     client_ins = docker.APIClient(base_url='tcp://' + node_ip + ":" + node_port, version='1.24', timeout=5)
#     print("      Create the container......")
#     container_ret = client_ins.create_container(image=conf['Image'],
#                                                 stdin_open=conf['OpenStdin'],
#                                                 tty=conf['Tty'],
#                                                 command=conf['Cmd'],
#                                                 name=conf['Name'],
#                                                 hostname=conf['Hostname'],
#                                                 host_config=conf['HostConfig'])
#     if container_ret:
#         time.sleep(0.3)
#         return (container_ret['Id'])

# from model.mysql_server1 import MysqlServer
# from settings import DATABASES
#
# obj = MysqlServer(DATABASES)
# l = obj.run_sql('select * from user')
#
# print (l)

from myswarm import Myswarm
myswarm = Myswarm()
ret = myswarm.show_port('192.168.100.200','2375','1a537')
print (ret)