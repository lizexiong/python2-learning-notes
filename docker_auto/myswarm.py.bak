# -*- coding: utf-8 -*-

import socket
import time

import docker,errno
from curl import Curl

from model.node import NodeInfo
from settings import DOCKER_API_VERSION

class Myswarm(object):
    #测试该端口是否开启
    def ping_port(self,ip,port):
        cs = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        cs.settimeout(0.15)
        address = (str(ip),int(port))
        try:
            cs.connect((address))
        except socket.error as e:
            print ("ping",ip,port,e)
            return 1
        cs.close()
        return 0

    #如果没有那么新增一个容器
    def insert_con_usage(self,node_ip, container_ip, container_id):
        if not container_id:
            return
        else:
            NodeInfo.insert_con_usage(container_id,container_ip,node_ip)

    #删除这个容器
    def delete_con_usage(self, container_id):
        if not container_id:
            return
        else:
            NodeInfo.delete_con_usage(container_id)

    #通过http的方式获取单个容器的详细信息
    def _container_detail(self, node_ip, node_port, containers_id):
        url = ('http://' + node_ip + ":" + node_port + "/containers/" + containers_id + "/json")
        container_more_url = Curl(url)
        ret_json = container_more_url.get_value()
        return ret_json

    #取出这个节点下的所有容器信息
    def container_list(self,node_ip,node_port,action=None):
        action = action
        # print ("node_ip:",node_ip,"node_port:",node_port)
        url = 'http://' + node_ip + ":" + node_port + "/containers/json?all=1"
        container_url = Curl(url)
        ret_json = container_url.get_value()

        con_data = {}
        online_list = {}
        offline_list = {}
        container_id = []       #存储容器id的前12位
        if ret_json:
            for i in ret_json:
                container_id.append(i['Id'][0:12])
        else:
            return con_data

        if len(container_id) < 1:
            return con_data
        else:
            con_num = 1
            for con_id in container_id:
                tmp_dict = {}
                ret_json = self._container_detail(node_ip, node_port, con_id)
                if len(ret_json) < 1:
                    return con_data
                con_state = ""
                if ('Running' in ret_json['State'].keys()) and (
                        'Status' not in ret_json['State'].keys()):      # for docker 1.7
                    con_state = str(ret_json['State']['Running'])
                elif 'Status' in ret_json['State'].keys():              # for docker 1.9 and higher
                    con_state = str(ret_json['State']['Status'])
                else:  # for else
                    con_state = "Exited"

                if con_state == "running":
                    tmp_dict['id_num'] = ret_json['Id'][0:12]
                    tmp_dict['con_ip'] = ret_json['NetworkSettings']['IPAddress']
                    tmp_dict['name'] = ret_json['Name']
                    tmp_dict['cpuperiod'] = ret_json['HostConfig']['CpuPeriod']
                    tmp_dict['cpuquota'] = ret_json['HostConfig']['CpuQuota']
                    tmp_dict['memory'] = ret_json['HostConfig']['Memory']
                    tmp_dict['state'] = con_state
                    tmp_dict['cmd'] = str(ret_json['Config']['Cmd'])
                    tmp_dict['created'] = ret_json['State']['StartedAt'].split('.')[0]
                    online_list[con_num] = tmp_dict
                    con_num += 1
                else:
                    tmp_dict['id_num'] = ret_json['Id'][0:12]
                    tmp_dict['con_ip'] = ret_json['NetworkSettings']['IPAddress']
                    tmp_dict['name'] = ret_json['Name']
                    tmp_dict['cpuperiod'] = ret_json['HostConfig']['CpuPeriod']
                    tmp_dict['cpuquota'] = ret_json['HostConfig']['CpuQuota']
                    tmp_dict['memory'] = ret_json['HostConfig']['Memory']
                    tmp_dict['state'] = con_state
                    tmp_dict['cmd'] = str(ret_json['Config']['Cmd'])
                    tmp_dict['created'] = ret_json['State']['StartedAt'].split('.')[0]
                    offline_list[con_num] = tmp_dict
                    con_num += 1

            if action == 'online':
                con_data = online_list
            elif action == 'offline':
                con_data = offline_list
            else:
                con_data = online_list.copy()
                con_data.update(offline_list)

        # print (con_data)

        return con_data


    def images_list(self, node_ip, node_port):
        client_ins = docker.APIClient(base_url='tcp://' + node_ip + ':' + node_port, version=DOCKER_API_VERSION, timeout=5)
        res_json = client_ins.images()
        images_list = []
        for i in res_json:
            images_list.append(i['RepoTags'])
        return images_list

    def create_container(self, node_ip, node_port, conf):
        client_ins = docker.APIClient(base_url='tcp://' + node_ip + ":" + node_port, version=DOCKER_API_VERSION, timeout=5)


        port_list = [8080,8081,80,3306,3000,22,5672,]
        if conf['Port']:  #检查port有没有值，一般为key，有key就是用户有自定义端口号输入
            for i in conf['Port'].keys():
                port_list.append(i)
        port_dict = {}
        for i in port_list:
            port_dict[i] = None

        #默认的卷挂载字典，如果用户没有输入，那么默认挂载tools卷到容器
        volume_tmp_dict = {
                        '/tools':{
                        'bind':'/tools',
                        'mode':'ro',
                                  },
                            }
        if conf['Binds']:
            volume_dict = dict(volume_tmp_dict,**conf['Binds'])
        else:
            volume_dict = volume_tmp_dict
        print ("volume_dict",volume_dict)
        volume_list = []  #存储卷配置的列表
        for volume in volume_dict.keys():
            volume_list.append(volume)

        host_config=client_ins.create_host_config(port_bindings=port_dict,
                                                  binds = volume_dict,
                                                  volumes_from = ['test',],
                                            # binds={
                                            #     '/tools':{
                                            #         'bind':'/ctools',
                                            #         'mode':'ro',
                                            #                },
                                            #     '/test1':{
                                            #         'bind':'/test1',
                                            #         'mode':'ro',
                                            #     }
                                            # }
                                            # con_id:server_id 以下是未优化前写法
                                            # 8080: None,
                                            # 8081:None,
                                            ),
        print ("host_config",host_config)
        #把生成的配置文件加入到全局配置文件
        conf['HostConfig']['PortBindings'] = host_config[0]['PortBindings']
        conf['HostConfig']['Binds'] = host_config[0]['Binds']
        conf['HostConfig']['VolumesFrom'] = host_config[0]['VolumesFrom']


        container_ret = client_ins.create_container(
                                                    image=conf['Image'],
                                                    stdin_open=conf['OpenStdin'],
                                                    tty=conf['Tty'],
                                                    command=conf['Cmd'],
                                                    name=conf['Name'],
                                                    ports = port_list,
                                                    volumes= volume_list,
                                                    #con_id 以下是未优化前写法
                                                    # ports = [8080,8081,80,3306,3000,22,5672,11111],
                                                    hostname=conf['Hostname'],
                                                    host_config=conf['HostConfig'])

        if container_ret:
            time.sleep(0.3)
            return (container_ret['Id'])
        else:
            print("Can not create container")
            return

    def start_container(self, node_ip, node_port, container_id):
        # print ("node_ip:",node_ip,"container_id:",container_id)
        if len(container_id) > 0:
            container_ip = ""
            try:
                client_ins = docker.APIClient(base_url='tcp://' + node_ip + ":" + node_port, version=DOCKER_API_VERSION, timeout=5)
                client_ins.start(container_id)
            except  docker.errors.NotFound as e:
                print ("container anomaly...")

            time.sleep(0.5)
            con_info = self._container_detail(node_ip, node_port, container_id)
            # self.insert_con_usage(node_ip, con_info['NetworkSettings']['IPAddress'], container_id[0:12])
        else:
            print("Please enter the Container ID")
            return

    def container_info(self, node_ip, node_port, container_id):
        con_data = {}
        tmp_dict = {}
        ip_ret = ""
        ret_json = self._container_detail(node_ip, node_port, container_id)
        if len(ret_json) < 1:
            return con_data

        con_state = ""
        if ('Running' in ret_json['State'].keys()) and ('Status' not in ret_json['State'].keys()):  # for docker 1.7
            con_state = str(ret_json['State']['Running'])
        elif 'Status' in ret_json['State'].keys():  # for docker 1.9 and higher
            con_state = str(ret_json['State']['Status'])
        else:  # for else
            con_state = "Exited"
        tmp_dict['id_num'] = ret_json['Id'][0:12]
        tmp_dict['node_ip'] = node_ip
        tmp_dict['con_ip'] = ret_json['NetworkSettings']['IPAddress']
        tmp_dict['name'] = ret_json['Name']
        tmp_dict['image'] = ret_json['Image']
        tmp_dict['created'] = ret_json['State']['StartedAt'].split('.')[0]
        tmp_dict['state'] = con_state
        tmp_dict['memory'] = ret_json['HostConfig']['Memory']
        tmp_dict['cpuperiod'] = ret_json['HostConfig']['CpuPeriod']
        tmp_dict['cpuquota'] = ret_json['HostConfig']['CpuQuota']
        tmp_dict['hostname'] = str(ret_json['Config']['Hostname'])
        tmp_dict['cmd'] = str(ret_json['Config']['Cmd'])
        con_data[1] = tmp_dict
        return con_data

    def stop_container(self, node_ip, node_port, container_id):
        if len(container_id) > 0:
            print("      Stop the container %s ........" % container_id)
            client_ins = docker.APIClient(base_url='tcp://' + node_ip + ":"
                                                + node_port, version=DOCKER_API_VERSION, timeout=5)
            client_ins.stop(container_id)
        else:
            print("Please enter the Container ID")
            return

    def destroy_container(self, node_ip, node_port, container_id):
        if len(container_id) > 0:
            print("      Destroy the container %s ....... " % container_id)
            client_ins = docker.APIClient(base_url='tcp://' + node_ip + ':'
                                                + node_port, version=DOCKER_API_VERSION, timeout=5)
            try:
                client_ins.stop(container_id)
                time.sleep(0.3)
                client_ins.remove_container(container_id)
                time.sleep(0.3)
            except docker.errors.NotFound:
                print("      NO Such container id")
            self.delete_con_usage(container_id)
        else:
            print("Please enter the Container ID")
            return 1

    def online_node_con_info(self,node_ip,node_port,con_id):
        pass

    def check_volumes_from(self,node_ip,node_port):
        containers = self.container_list(node_ip,node_port,all)
        print (containers)