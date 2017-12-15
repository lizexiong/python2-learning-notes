# -*- coding: utf-8 -*-


from settings import DATABASES
from .mysql_server import MysqlServer
import pymysql



class NodeInfo(object):
    @staticmethod
    #返回node的所有信息
    def node_info(status):
        db = MysqlServer(DATABASES)
        if  status == "online" or status == "offline":
            sql = "select * from node where state = '%s'" %(status)
        else:
            sql = "select * from node"
        ret = db.run_sql(sql)
        db.close()
        return ret

    @staticmethod
    def node_online_offine(status):
        db = MysqlServer(DATABASES)
        sql = "select * from node where state = '%s'" %(status)
        ret = db.run_sql(sql)
        db.close()
        return ret

    @staticmethod
    def node_online_list():
        db = MysqlServer(DATABASES)
        sql = "select node_ip from node where state = 'online' "
        ret = db.run_sql(sql)
        db.close()
        return ret



    @staticmethod
    def group_list():
        db = MysqlServer(DATABASES)
        #distinct是取出列的信息,列的信息就是组列表
        sql = "select distinct `node_group` from node"
        ret = db.run_sql(sql)
        db.close()
        return ret

    @staticmethod
    #查询这个组里面的node信息
    def node_list(node_group):
        db = MysqlServer(DATABASES)
        sql = "select `node_ip` from node where node_group=" + '"' + node_group + '"' "and state = 'online'"
        ret = db.run_sql(sql)
        db.close()
        return ret

    @staticmethod
    #查询这个node的端口信息
    def get_node_port(node_ip):
        db = MysqlServer(DATABASES)
        sql = "select `port` from node where node_ip='%s'" % node_ip
        ret = db.run_sql(sql)
        db.close()
        return ret

    @staticmethod
    #新增容器
    def insert_con_usage(con_id, con_ip, node_ip,state):
        db = MysqlServer(DATABASES)
        sql = "insert into con_usage(con_id, con_ip, node_ip,state) values('%s','%s','%s','%s')" % (con_id, con_ip, node_ip,state)
        db.execute_sql(sql)
        db.close()
        return 0

    @staticmethod
    def update_con_status(con_id,state):
        db = MysqlServer(DATABASES)
        sql = "update con_usage set state = '%s' where  con_id = '%s'" %(state,con_id)
        db.run_sql(sql)
        db.close()



    @staticmethod
    def delete_con_usage(con_id):
        db = MysqlServer(DATABASES)
        sql = "delete from con_usage where con_id='%s'" % con_id
        db.execute_sql(sql)
        db.close()
        return 0

    @staticmethod
    def con_usage_info():
        db = MysqlServer(DATABASES)
        sql = "select `con_id`,`con_ip`,`node_ip`,`state`,`user_name`,`con_app`,`con_desc` from con_usage"
        result = db.run_sql(sql)
        db.close()
        return result

    @staticmethod
    def get_con_usage_modify(result):
        db = MysqlServer(DATABASES)
        sql = "select `con_id`,`con_ip`,`node_ip`,`state`,`user_name`,`con_app`,`con_desc` from con_usage where con_id='%s'" % result
        ret = db.run_sql(sql)
        # db.close()
        return ret

    @staticmethod
    def set_con_usage_modify(result):
        db = MysqlServer(DATABASES)
        sql = "update con_usage set con_desc='%s',con_app='%s',user_name='%s' where con_id = '%s'" \
              %(result['con_desc'],result['con_app'],result['user_name'],result['con_id'])
        try:
            ret = db.run_sql(sql)
            db.close()
        except pymysql.Error as e:
            return "Fail"
        return ret

    @staticmethod
    def node_check(result):
        db =MysqlServer(DATABASES)
        sql = "select * from node where node_ip = '%s'" %(result)
        ret =db.run_sql(sql)
        db.close()
        if ret:
            return 'False' #如果没有结果那么就是没有这个节点，那么返回False
        else:
            return  "True"

    @staticmethod
    def node_add(result):
        db = MysqlServer(DATABASES)
        sql = "insert into node (name, node_ip, port, cpus, mem, images, state, node_group, containers, os_version,  " \
              "kernel_version, docker_version) values('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s')"\
              %(result['name'], result['node_ip'], result['port'], result['cpus'], result['mem'],
                result['images'], result['state'], result['node_group'], result['containers'],
                result['os_version'], result['kernel_version'],result['docker_version'])
        try:
            ret = db.run_sql(sql)
        except pymysql.Error as e:
            print (e)
            return 'Fail'
        return ret

    @staticmethod
    def node_delete(result):
        db = MysqlServer(DATABASES)
        node_delete_sql = "delete from node where node_ip = '%s'" % (result)
        con_delete_sql = "delete from con_usage where node_ip = '%s'" %(result)
        try:
            node_ret = db.run_sql(node_delete_sql,)
            con_ret = db.run_sql(con_delete_sql)
            ret = node_ret + con_ret
        except pymysql.Error as e:
            return "Fail"
        return ret

    @staticmethod
    def node_modify(result):
        db = MysqlServer(DATABASES)
        sql = "select id, name, node_ip, port, cpus, mem, images, state, node_group, containers, os_version, kernel_version," \
              "docker_version from node where node_ip = '%s'" %(result)
        try:
             ret = db.run_sql(sql)
        except pymysql.Error as e:
            return "Fail"
        return ret

    @staticmethod
    def node_update(result):
        db = MysqlServer(DATABASES)
        update_tag = result.get('online_node_ip',None)
        if not update_tag:
            sql = "update node set name='%s', node_ip='%s', port='%s', cpus='%s', mem='%s', images='%s', state='%s', " \
                  "node_group='%s', containers='%s', os_version='%s', kernel_version='%s', docker_version='%s' where node_ip = '%s'" %(
                result['name'],result['node_ip'],result['port'],result['cpus'],result['mem'],result['images'],result['node_status'],result
                ['node_group'], result['containers'], result['os_version'], result['kernel_version'], result['docker_version'],
                result['node_ip']
            )
        else:
            sql = "update node set images='%s' , containers = '%s' where node_ip = '%s'" %(result['images'],result['containers'],
                                                                                           result['online_node_ip'])
        try:
            ret = db.run_sql(sql)
        except pymysql.Error as e:
            return "Fail"
        db.close()
        return ret

    @staticmethod
    def node_status_update(result):
        db = MysqlServer(DATABASES)
        sql = "update node set state='%s' where node_ip = '%s'" %(result['status'],result['node_ip'])
        ret = db.run_sql(sql)
        return ret
