# -*- coding: utf-8 -*-

import threading
import json
import time

import tornado.web

from .base import BaseHandler
from settings import template_variables
from model.node import NodeInfo
from myswarm import Myswarm
from model.data_manage import DataManage
from config import basejson
from model import mysql_server

class Main(BaseHandler):

    @tornado.web.authenticated
    def get(self,*args,**kwargs):
        self.render("node/main.html")

class NodeManage(BaseHandler):

    def get(self,*args, **kwargs):

        #加载界面之前，更新节点状态
        node_status_check = online_check('image')
        node_status_check.trigger()


        action = self.get_argument('action','None')
        node_data = NodeInfo.node_info(action)
        node_data_handled = DataManage.manage_node_info(node_data)
        is_admin = self.is_admin()[0][0] #取出组id，admin的组外键id为1
        self.render("node/node_manage.html", node_data = node_data_handled,is_admin = is_admin)

class Top(BaseHandler):

    @tornado.web.authenticated
    def get(self):
        self.render("base.html", name = template_variables)


class LeftGroup(BaseHandler):

    @tornado.web.authenticated
    def get(self):
        self.render('node/leftgroup.html')


class GroupList(BaseHandler):

    @tornado.web.authenticated
    def post(self,):
        id = self.get_argument("id", None)
        name = self.get_argument("n", None)
        lv = self.get_argument('lv', None)
        print ("id:",id,"name:",name,"lv:",lv)
        alldata = []
        if id == None and lv == None and name == None:
            alldata = self._getgroup()
        elif id != "" and lv == "0":
            alldata = self._getnode(id, name)
        elif lv == '1':
            alldata = self._getcontainer(id,name)
        print (alldata)
        self.write(json.dumps(alldata))

    def _getgroup(self):
        group_data = []
        group_set = NodeInfo.group_list()
        for i in DataManage.group_list(group_set):
            group_data.append(i)
        return group_data

    def _getnode(self,id,name):
        node_ret = NodeInfo.node_list(name)
        node_data = DataManage.node_list(node_ret, id, name)
        return node_data

    #此函数为了防止zTree异步请求报错，下面根本就没有这些函数
    def _getcontainer(self,id,name):
        container_ret  = NodeInfo.container_list(name)
        container_data = DataManage.container_list(container_ret, id, name)
        return container_data


class ConManage(BaseHandler):

    @tornado.web.authenticated
    def get(self, *args, **kwargs):
        #加载所有在线节点的所有容器信息并判断存储进入数据库
        # node_status_check = online_check()
        # node_status_check.trigger()

        online_node_list = NodeInfo.node_info('online')
        # print (online_node_list)

        if online_node_list:
            myswarm = Myswarm()
            for i in online_node_list:
                node_ip = i[2]
                node_port = i[3]
                action = None
                ret = myswarm.container_list(node_ip,node_port,action)
                print ("ret",ret)
            for i,j in ret.items():
                id_num = ret[i]['id_num']
                con_ip = ret[i]['con_ip']
                state = ret[i]['state']
                con_info = NodeInfo.get_con_usage_modify(id_num)
                if con_info: #如果不为空，代表数据库已经有这个数据,直接退出
                    NodeInfo.update_con_status(id_num,state)
                else:
                    NodeInfo.insert_con_usage(id_num,con_ip,node_ip,state)

            #以下代码为判断是渲染所有容器还是有容器id的内容
            con_id = self.get_argument('con_id', 'none')
            if con_id == 'none':
                con_data = NodeInfo.con_usage_info()
            else:
                con_data = NodeInfo.get_con_usage_modify(con_id)
            # print (con_data)
            con_data_handled = DataManage.manage_con_usage_info(con_data)
            self.render("node/con_list.html",name=template_variables, con_data = con_data_handled)
        else:
            self.write('没有节点在线')

class ConModify(BaseHandler):

    @tornado.web.authenticated
    def get(self, *args, **kwargs):
        con_id = self.get_argument('con_id')
        # print ('-----++++---',con_id)
        con_data = NodeInfo.get_con_usage_modify(con_id)
        con_data_handled = DataManage.manage_con_usage_info(con_data)
        # print ('----++++++----',con_data_handled)
        self.render("node/con_modify.html", name=template_variables, single_con_usage_data = con_data_handled)

    @tornado.web.authenticated
    def post(self,*args, **kwargs):
        con_dic = {}
        tmp_dict = {'url':'conmanage'}
        for key in ['con_id', 'con_desc', 'con_app', 'user_name']:
            con_dic[key] = self.get_argument(key)
        con_ret = NodeInfo.set_con_usage_modify(con_dic)
        if not con_ret:
            tmp_dict['tag'] = True
            tmp_dict['con_id'] = con_dic['con_id']
            ret_url = url_script.url_succ(argument=tmp_dict)
        else:
            tmp_dict['str'] = '修改失败,可能数据类型错误'
            ret_url = url_script.url_fail(argument=tmp_dict)
        self.write(ret_url)

    def delete(self, *args, **kwargs):
        print ('delete')

class RightNode(BaseHandler):

    @tornado.web.authenticated
    def get(self,*args,**kwargs):
        node_ip = self.get_argument('node_ip', None)
        action  = self.get_argument('action',None)
        if node_ip is None:
            self.write('Nothins site')
        else:
            node_port = NodeInfo.get_node_port(node_ip)[0][0]
            myswarm = Myswarm()
            con_data = myswarm.container_list(node_ip, node_port,action)
            self.render('node/rightnode.html',con_data = con_data,node_ip = node_ip)


class ConCreate(BaseHandler):
    @tornado.web.authenticated
    def get(self, *args, **kwargs):
        node_ip = self.get_argument('node_ip', None)
        if node_ip is None:
            self.write("Something Wrong")
            return
        else:
            node_port = NodeInfo.get_node_port(node_ip)[0][0]
            myswarm = Myswarm()
            images_data = myswarm.images_list(node_ip, node_port)
            mount_con_list = myswarm.check_volumes_from(node_ip,node_port)
        self.render('node/con_create.html',node_ip = node_ip, images = images_data,mounts=mount_con_list)

    @tornado.web.authenticated
    def post(self, *args, **kwargs):
        json_ret = json.loads(basejson[0])
        node_ip = self.get_argument('node_ip', 'None')
        if node_ip == 'None':
            print("There is no node ip")
            return
        port_ret = NodeInfo.get_node_port(node_ip)
        if len(port_ret) < 1:
            print("There is no port of the node")
            return
        else:
            node_port = port_ret[0][0]

        con_dict = {}
        tmp_dict = {'url':'node'}
        for key in ['Cmd', 'Image', 'CpuPeriod', 'CpuQuota','ConNat', 'Name','Binds','Mounts']:
            con_dict[key] = self.get_argument(key.lower())
            if key == 'Cmd' and con_dict[key] != '':
                json_ret [key] = con_dict[key].split()
            elif key == 'Image' and con_dict[key] != "":
                json_ret[key] = con_dict[key]
            elif key == 'Name' and con_dict[key] != "":
                json_ret[key] = con_dict[key]
            elif key == 'Name' and con_dict[key] == "":
                import uuid
                json_ret['Name'] = str(uuid.uuid4())[0:13]
                json_ret['Hostname'] = json_ret['Name']
            elif key == 'ConNat' and con_dict[key] != "":
                port_list = list(con_dict[key].split(','))
                port_list.append('')   #加一个空字符就是为怕没有空字符报错,所以加一个进去
                while '' in port_list:
                    port_list.remove('') #取出列表的空元素，因为,后面会分割出一个空字符串来
                # print ('port_list',port_list)
                for port in port_list:
                    json_ret['Port'][port] = {}
            elif key == 'Binds' and con_dict[key] != "":
                volume_list = list(con_dict[key].split(','))
                volume_list.append('')
                while '' in volume_list:
                    volume_list.remove('')
                volume_dict = {}
                try:
                    for volume in volume_list:
                        volume_split_list = volume.split(':')
                        s_volume = volume_split_list[0]
                        c_volume = volume_split_list[1]
                        volume_dict[s_volume] = {'bind': c_volume,'mode':'ro'}
                except Exception as e:
                    print (e)
                json_ret['Binds'] = volume_dict
            elif key == 'Mounts' and con_dict[key] != "":
                json_ret['Mounts'] = con_dict[key]
            elif con_dict[key] != "":
                json_ret['HostConfig'][key] = int(con_dict[key])

        myswarm = Myswarm()
        # import uuid
        # json_ret['Name'] = str(uuid.uuid4())[0:13]
        json_ret['Hostname'] = json_ret['Name']
        print (json_ret)
        try:
            container_id = myswarm.create_container(node_ip, node_port, json_ret)
        except Exception as e :
            tmp_dict['str'] = ('容器名已存在或端口等参数输入不合法..')
            tmp_dict['node_ip'] = node_ip
            ret_url = url_script.url_fail(argument = tmp_dict)
            self.write(ret_url)
            return

        if not container_id:
            tmp_dict['str'] = ('容器创建失败')
            ret_url = url_script.url_fail(argument = tmp_dict)
            print("Can not create the Container")
            self.write(ret_url)
        try:
            ret = myswarm.start_container(node_ip, node_port, container_id)
        except Exception as e:
            tmp_dict['str'] = ('容器端口号可能已占用,无法启动...')
            tmp_dict['node_ip'] = node_ip
            ret_url = url_script.url_fail(argument = tmp_dict)
            self.write(ret_url)
            return
        if not ret:
            tmp_dict['node_ip'] = node_ip
            tmp_dict['tag'] = True
            ret_url = url_script.url_succ(argument=tmp_dict)
            self.write(ret_url)

class ConAction(BaseHandler):

    @tornado.web.authenticated
    def get(self, *args, **kwargs):
        node_ip = self.get_argument('node_ip')
        con_id = self.get_argument('con_id')
        port_ret = NodeInfo.get_node_port(node_ip)
        if len(port_ret) < 1 :
            print("There is no port of the node")
            return
        else:
            node_port = port_ret[0][0]

        myswarm = Myswarm()
        try:
            con_data_handled = myswarm.container_info(node_ip, node_port, con_id)
            show_port = myswarm.show_port(node_ip,node_port,con_id)
        except BaseException as e:
            NodeInfo.delete_con_usage(con_id)
            tmp_dict = {'url':'conmanage'}
            tmp_dict['str'] = "没有这个容器,等待获取最新信息..."
            ret_url = url_script.url_fail(argument=tmp_dict)
            self.write(ret_url)
            return

        # print ("con_data_handled",con_data_handled)

        '''
        在其它网页像此页面跳转时，如果数据库早已存在该数据,但是节点时候获取没有这个容器，
        那么就把这条数据从数据库里面删除.(此现象会发生在后台手动命令删除容器时)
        '''
        # tmp_con_id = []
        # for i,j in con_data_handled.items():
        #     tmp_con_id.append(con_data_handled[i]['id_num'])
        # if con_id in tmp_con_id:
        #     pass
        #     print ('is con_id')
        # else:
        #     print ('not con_id')
        #     NodeInfo.delete_con_usage(con_id)
        #     tmp_dict = {'url':'conmanage'}
        #     ret_url = url_script.url_succ(argument=tmp_dict)
        #     self.write(ret_url)

        self.render("node/con_action.html", name=template_variables, node_ip=node_ip,
            node_port=node_port, con_id=con_id, con_data=con_data_handled,show_port = show_port)

class ConStart(BaseHandler):

    @tornado.web.authenticated
    def get(self, *args, **kwargs):
        con_dict = {}
        tmp_dict = {'url':'conaction'}
        for key in ['node_ip','port','con_id']:
            con_dict[key] = self.get_argument(key)
        myswarm = Myswarm()
        if not con_dict['con_id']:
            self.write("There is no container id")
        print("      Starting the container......")
        ret = myswarm.start_container(con_dict['node_ip'], con_dict['port'], con_dict['con_id'])
        if ret is None:
            tmp_dict['node_ip'] = con_dict['node_ip']
            tmp_dict['con_id'] = con_dict['con_id']
            tmp_dict['tag'] = True
            ret_url = url_script.url_succ(argument=tmp_dict)
        else:
            tmp_dict['str'] = '启动容器失败'
            ret_url = url_script.url_succ(argument=tmp_dict)
        self.write(ret_url)

class ConStop(BaseHandler):

    @tornado.web.authenticated
    def get(self, *args, **kargs):
        con_dict = {}
        tmp_dict = {'url':'conaction'}
        for key in ['node_ip', 'port', 'con_id']:
            con_dict[key] = self.get_argument(key)
        myswarm = Myswarm()
        ret = myswarm.stop_container(con_dict['node_ip'], con_dict['port'], con_dict['con_id'])
        if ret is None:
            tmp_dict['node_ip'] = con_dict['node_ip']
            tmp_dict['con_id'] = con_dict['con_id']
            tmp_dict['tag'] = True
            ret_url = url_script.url_succ(argument=tmp_dict)
        else:
            tmp_dict['str'] = '停止容器失败'
            ret_url = url_script.url_succ(argument=tmp_dict)
        self.write(ret_url)


class ConRestart(BaseHandler):

    @tornado.web.authenticated
    def get(self, *args, **kwargs):
        con_dict = {}
        tmp_dict = {'url':'conaction'}
        for key in ['node_ip', 'port', 'con_id']:
            con_dict[key] = self.get_argument(key)
        myswarm = Myswarm()

        if not con_dict['con_id']:
            self.write("There is no container id")
        ret1 = myswarm.stop_container(con_dict['node_ip'], con_dict['port'], con_dict['con_id'])
        time.sleep(2)
        if ret1 is None:
            ret2 = myswarm.start_container(con_dict['node_ip'], con_dict['port'], con_dict['con_id'])
            if ret2 is None:
                tmp_dict['node_ip'] = con_dict['node_ip']
                tmp_dict['con_id'] = con_dict['con_id']
                tmp_dict['tag'] = True
                ret_url = url_script.url_succ(argument=tmp_dict)
            else:
                tmp_dict['str'] = '重启时启动失败...'
                ret_url = url_script.url_fail(argument=tmp_dict)
        else:
            tmp_dict['str'] = '重启时停止失败...'
            ret_url = url_script.url_fail(argument=tmp_dict)
        self.write(ret_url)


class ConDestory(BaseHandler):

    @tornado.web.authenticated
    def get(self, *args, **kargs):
        con_dict = {}
        tmp_dict = {'url':'node'}
        for key in ['node_ip', 'port', 'con_id']:
            con_dict[key] = self.get_argument(key)
        myswarm = Myswarm()
        ret = myswarm.destroy_container(con_dict['node_ip'], con_dict['port'], con_dict['con_id'])
        if ret is None:
            tmp_dict['node_ip'] = con_dict['node_ip']
            tmp_dict['tag'] = True
            ret_url = url_script.url_succ(argument=tmp_dict)
        else:
            tmp_dict['str'] = '删除失败'
            ret_url = url_script.url_succ(argument=tmp_dict)
        self.write(ret_url)


class NodeAdd(BaseHandler):

    @tornado.web.authenticated
    def get(self,*args, **kwargs):
        self.render("node/node_create.html")

    @tornado.web.authenticated
    def post(self, *args, **kwargs):
        con_dict = {}
        tmp_dict = {'url':'nodemanage'} #存储传入错误的url参数字典
        for key in ['name','node_ip','port','cpus','mem','images','state','node_group','containers','os_version','kernel_version','docker_version','remark']:
            con_dict[key] = self.get_argument(key)
        myswarm = Myswarm()
        ping_ret = myswarm.ping_port(con_dict['node_ip'],con_dict['port'])
        if ping_ret == 0:
            con_dict['state'] = 'online'
        else:
            con_dict['state'] = 'offline'
        node_check_ret = NodeInfo.node_check(con_dict['node_ip'])
        if not con_dict['node_ip'] and con_dict['port']:
            tmp_dict['str'] = 'IP以及端口可能没有填写'
            ret_url = url_script.url_fail(argument = tmp_dict)
            self.write(ret_url)
        elif node_check_ret == "False":
            tmp_dict['str'] = '节点IP已存在'
            ret_url = url_script.url_fail(argument = tmp_dict)
            self.write(ret_url)
        else:
            ret = NodeInfo.node_add(con_dict)
            if not ret:
                ret_url = url_script.url_succ(argument = tmp_dict)
            else:
                tmp_dict['str'] = '添加失败,可能数据类型不合法'
                ret_url = url_script.url_fail(argument = tmp_dict)
            self.write(ret_url)

class NodeModify(BaseHandler):
    def get(self, *args, **kwargs):
        action = self.get_argument('action')
        node_ip = self.get_argument('node_ip')
        tmp_dict = {'url':'nodemanage'}
        if action == "modify":
            node_data = NodeInfo.node_modify(node_ip)
            single_node_data = DataManage.manage_node_info(node_data)
            self.render('node/node_modify.html',single_node_data=single_node_data)
        elif action == "delete":
            ret = NodeInfo.node_delete(node_ip)
            if not ret:  #node_delete删除语句如果正常删除是没有结果返回的，所以为空，not
                ret_url = url_script.url_succ(argument=tmp_dict)
                self.write(ret_url)
            else:
                tmp_dict['str'] = ['删除失败']
                ret_url = url_script.url_fail(argument=tmp_dict)
                self.write(ret_url)

    def post(self, *args, **kwargs):
        con_dict = {}
        tmp_dict = {'url':'nodemanage'}
        for key in ['name','node_ip','port','cpus','mem','images','state','node_group','containers','os_version','kernel_version','docker_version','remark']:
            con_dict[key] = self.get_argument(key)
        myswarm = Myswarm()
        ping_ret = myswarm.ping_port(con_dict['node_ip'],con_dict['port'])
        if ping_ret == 0:
            con_dict['node_status'] = 'online'
        else:
            con_dict['node_status'] = 'offline'
        print ("ping_ret:",ping_ret,"con_dict[node_status]",con_dict['node_status'])
        ret = NodeInfo.node_update(con_dict)
        print ('ret:',ret)
        if not ret:
            ret_url = url_script.url_succ(argument=tmp_dict)
            self.write(ret_url)
        else:
            tmp_dict['str'] = ("修改失败,可能数据类型不合法")
            ret_url = url_script.url_fail(argument=tmp_dict)
            self.write(ret_url)

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

class url_script(object):

    @staticmethod
    def url_succ(*args , **kwargs):
        node_ip = kwargs['argument'].get('node_ip',None)
        con_id = kwargs['argument'].get('con_id',None)
        url = kwargs['argument'].get('url',None)
        tag = kwargs['argument'].get('tag',None)
        print (node_ip,con_id,url)
        if node_ip and con_id and tag:
            url_cmd = ("<script language='javascript'>window.location.href='/" +  kwargs['argument']['url'] +
                       "?node_ip=" + str(kwargs['argument']['node_ip']) + "&con_id=" +  str(kwargs['argument']['con_id'])
                       +"';</script>")
        elif node_ip and con_id is None and tag:
            url_cmd = ("<script language='javascript'>window.location.href='/" +  kwargs['argument']['url'] +
                       "?node_ip=" + str(kwargs['argument']['node_ip']) + "';</script>")
        elif node_ip is None and con_id and tag:
            url_cmd = ("<script language='javascript'>window.location.href='/" +  kwargs['argument']['url'] +
                        "?con_id=" + str(kwargs['argument']['con_id']) + "';</script>")
        elif  node_ip is None and con_id is None and tag is None:
            url_cmd = ("<script language='javascript'>window.location.href='/" +  kwargs['argument']['url'] +
                       "';</script>")
        # print (url_cmd)
        return url_cmd

    @staticmethod
    def url_fail(*args, **kwargs):
        node_ip = kwargs['argument'].get('node_ip',None)
        print (node_ip)
        if node_ip:
            url_cmd =   ("<script language='javascript'>alert('" + kwargs['argument']['str'] + "')"
                        ";window.location.href='/" + kwargs['argument']['url'] + "?node_ip=" + node_ip +"';</script>")
        else:
            url_cmd =   ("<script language='javascript'>alert('" + kwargs['argument']['str'] + "')"
                        ";window.location.href='/" + kwargs['argument']['url'] +"';</script>")
        return url_cmd

