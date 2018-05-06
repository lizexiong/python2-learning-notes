# -*- coding: utf-8 -*-

import socket
import time
import threading

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
                    tmp_dict['state'] = con_state
                    tmp_dict['id_num'] = ret_json['Id'][0:12]
                    tmp_dict['con_ip'] = ret_json['NetworkSettings']['IPAddress']
                    tmp_dict['name'] = ret_json['Name']
                    # tmp_dict['cpuperiod'] = ret_json['HostConfig']['CpuPeriod']
                    # tmp_dict['cpuquota'] = ret_json['HostConfig']['CpuQuota']
                    tmp_dict['memory'] = ret_json['HostConfig']['Memory']
                    tmp_dict['state'] = con_state
                    tmp_dict['cmd'] = str(ret_json['Config']['Cmd'])
                    tmp_dict['started'] = ret_json['State']['StartedAt'].split('.')[0]
                    tmp_dict['mount'] = ret_json['Mounts']
                    tmp_dict['port'] = ret_json['HostConfig']['PortBindings']
                    online_list[con_num] = tmp_dict
                    con_num += 1
                else:
                    tmp_dict['id_num'] = ret_json['Id'][0:12]
                    tmp_dict['con_ip'] = ret_json['NetworkSettings']['IPAddress']
                    tmp_dict['name'] = ret_json['Name']
                    # tmp_dict['cpuperiod'] = ret_json['HostConfig']['CpuPeriod']
                    # tmp_dict['cpuquota'] = ret_json['HostConfig']['CpuQuota']
                    tmp_dict['memory'] = ret_json['HostConfig']['Memory']
                    tmp_dict['state'] = con_state
                    tmp_dict['cmd'] = str(ret_json['Config']['Cmd'])
                    tmp_dict['started'] = ret_json['State']['StartedAt'].split('.')[0]
                    tmp_dict['mount'] = ret_json['Mounts']
                    tmp_dict['port'] = ret_json['HostConfig']['PortBindings']
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

        port_list = [8080,80,3306,22,27017]
        if conf['Port']:  #检查port有没有值，一般为key，有key就是用户有自定义端口号输入
            for i in conf['Port'].keys():
                port_list.append(i)
        port_dict = {}

        from tools import port_allot
        port_q = port_allot(node_ip)
        used_port = self.check_used_port(node_ip,node_port)
        #取出已从队列分配端口号
        print (used_port)
        if used_port:
            max_used_port = int(max(used_port))
            tag = True
            while tag:
                max_port = port_q.get_q()
                if max_used_port == max_port:
                    port_q.get_q()
                    break;

        #若字典为空,那么就是docker自动分配随机端口,重启端口就会变化
        for i in port_list:
            port_dict[i] = port_q.get_q(i)

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
        volume_list = []  #存储卷配置的列表
        for volume in volume_dict.keys():
            volume_list.append(volume)

        if conf['Mounts'] and conf['Mounts'] != "None":  #因为前端传来的None是一个字符串,不是一个对象,所以只能用 !=来判断
            from_mount_con = conf['Mounts']
        else:
            from_mount_con = []


        host_config=client_ins.create_host_config(port_bindings=port_dict,
                                                  binds = volume_dict,
                                                  volumes_from = from_mount_con,
                                                  # volumes_from = ['test',],
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
        # print ("host_config",host_config)
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
            # except  docker.errors.NotFound as e:
            except Exception as e:
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
        print ('ret_json----------',ret_json)
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
        tmp_dict['image'] = ret_json['Config']['Image']
        tmp_dict['started'] = ret_json['State']['StartedAt'].split('.')[0]
        tmp_dict['created'] = ret_json['Created'].split('.')[0]
        tmp_dict['state'] = con_state
        tmp_dict['memory'] = ret_json['HostConfig']['Memory']
        tmp_dict['cpuperiod'] = ret_json['HostConfig']['CpuPeriod']
        tmp_dict['cpuquota'] = ret_json['HostConfig']['CpuQuota']
        tmp_dict['hostname'] = str(ret_json['Config']['Hostname'])
        tmp_dict['cmd'] = str(ret_json['Config']['Cmd'])
        if ret_json['HostConfig']['PortBindings']:
            tmp_dict['port'] = ret_json['HostConfig']['PortBindings']
        elif ret_json['NetworkSettings']['Ports']:
            tmp_dict['port'] = ret_json['NetworkSettings']['Ports']
        else:
            tmp_dict['port'] = None
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


    def docker_info(self,node_ip_list):
        docker_info = {}
        num = 1
        for i in node_ip_list:
            tmp_dict = {}
            url = ('http://' + i[0] + ":" + i[1] + "/info")
            container_more_url = Curl(url)
            ret_json = container_more_url.get_value()

            tmp_dict['Containers'] = ret_json['Containers']
            tmp_dict['ContainersRunning'] = ret_json['ContainersRunning']
            tmp_dict['Images'] = ret_json['Images']
            tmp_dict['DataSpaceTotal'] = ret_json['DriverStatus'][7][1]
            tmp_dict['DataSpaceAvailable'] = ret_json['DriverStatus'][8][1]
            tmp_dict['MemTotal'] = ret_json['MemTotal'] / 1048576

            docker_info[i[0]] = tmp_dict
        return docker_info


    def check_volumes_from(self,node_ip,node_port):
        containers = self.container_list(node_ip,node_port,all)
        mount_con_list = []
        for num, dict in containers.items():
            if containers[num]['mount']:
                mount_con_list.append(containers[num]['name'])
        mount_con_list = str(mount_con_list)

        from tools import OnlyCharNum
        mount_con_list_str = OnlyCharNum(mount_con_list)
        mount_con_list = mount_con_list_str.split(',')
        return mount_con_list

    #检查主机已使用端口列表,从队列拿掉
    def check_used_port(self,node_ip,node_port):
        con_list = self.container_list(node_ip,node_port,all)
        port_list = []
        for port_key in con_list.values():
             port_dict = port_key['port']
             for cport in port_dict.values():
                 for i in cport:
                     port_list.append(i['HostPort'])
        return port_list

    #格式化容器已映射使用端口,在前端展示
    def show_port(self,node_ip,node_port,con_id):
        port_dict = {}

        con_info = self.container_info(node_ip,node_port,con_id)
        print ("con_info",con_info)
        port_all = con_info[1]['port']
        print ("port_all",port_all,)
        num = 1
        if port_all:
            port_dict[num] = {}
            for i,j in port_all.items():
                tmp_dict = {}
                con_port = i.split('/')[0]
                tmp_dict['con_port'] = con_port
                tmp_dict['ser_port'] = j[0]['HostPort']
                port_dict[num] = tmp_dict
                num += 1
        else:
            port_dict = None
        return port_dict

class online_check(object):
    def __init__(self,action=None):
        self.action = action

    def trigger(self):
        threads = []
        node_update = threading.Thread(target=self._update_node())
        threads.append(node_update)
        print (1)

        for t in threads:
            #设置这些线程为守护线程，当所有常规线程运行完毕以后，守护线程不管运行到哪里，虚拟机都会退出运行。
            t.setDaemon(True)
            t.start()

    #原代码中,这里的函数就是为了检测节点是否在线,else后面的语句没有任何作用
    #检查节点是否为空
    def _update_node(self):
        node_data =NodeInfo.node_info(all)
        myswarm = Myswarm()

        for line in node_data:
            node_ip = line[2]
            node_port = line[3]
            if myswarm.ping_port(node_ip,node_port) == 1:
                result = {'status':'offline','node_ip':node_ip}
                NodeInfo.node_status_update(result)
            else:
                result = {'status':'online','node_ip':node_ip}
                NodeInfo.node_status_update(result)
        if self.action == "image":
            online_node_ip = NodeInfo.node_info('online')
            result = {}
            for line in online_node_ip:
                online_node_ip = line[2]
                online_node_port = line[3]
                images = myswarm.images_list(online_node_ip,online_node_port)
                containers = myswarm.container_list(online_node_ip,online_node_port)
                result['online_node_ip'] = online_node_ip
                result['online_node_port'] = online_node_port
                result['images'] = len(images)
                result['containers'] = len(containers)

                NodeInfo.node_update(result)