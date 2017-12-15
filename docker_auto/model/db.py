# -*- coding: utf-8 -*-

from sqlalchemy import create_engine,text,update
from sqlalchemy import Column,String,Integer,ForeignKey
#创建对象的基类
from sqlalchemy.ext.declarative import declarative_base
#创建DB的会话类型,就是传一些连接信息里面去
from sqlalchemy.orm import sessionmaker


engine = create_engine('mysql://root:huawei@localhost:3306/docker',
                       pool_size=1000,echo=False
                       )

Base = declarative_base()

class NodeDB(Base):
    __tablename__ = 'node'
    id = Column(Integer,primary_key=True)                       #自增关键字
    name = Column(String(32))                                   #节点的主机名
    node_ip = Column(String(32))                                #节点的IP地址
    port = Column(String(32))                                   #节点的端口
    cpus = Column(String(32))                                   #节点的CPU个数
    mem = Column(String(32))                                    #节点的内存
    images = Column(String(32))                                 #节点的镜像数
    state = Column(String(32))                                  #节点状态
    node_group = Column(String(32))                             #节点所在的组
    containers = Column(String(32))                             #节点上的容器数
    os_version = Column(String(32))                             #节点操作系统版本
    kernel_version = Column(String(32))                         #节点内核版本
    docker_version = Column(String(32))                         #节点docker版本
    is_active = Column(String(32),default=True)

    def __repr__(self):
        return ("<NodeDB>(name = '%s',ip = '%s', port = '%s', cpus = '%s',mem = '%s', \
                image = '%s',state = '%s', node_group = '%s', containers = '%s',os_version= '%s', \
                kernel_version = '%s',docker_version = '%s',is_active = '%s')")   \
            %(     self.name,
                   self.node_ip,
                   self.port,
                   self.cpus,
                   self.mem,
                   self.images,
                   self.state,
                   self.node_group,
                   self.containers,
                   self.os_version,
                   self.kernel_version,
                   self.docker_version,
                   self.is_active
            )


class ConUsageDB(Base):
    __tablename__ = "con_usage"
    id = Column(Integer,primary_key=True)
    con_id = Column(String(64))                                     #容器ID
    con_ip = Column(String(32))                                   #容器IP地址
    node_ip = Column(String(32))                                    #容器所在节点IP
    user_name = Column(String(32))                                  #容器用户名
    con_app = Column(String(512))                                    #容器上运行APP
    con_desc = Column(String(512))                                   #容器其它描述

    def __repr__(self):
        return ("<ConsumerDB(con_id = '%s',con_addr '%s', \
                node_ip = '%s',user_name ='%s',con_app = '%s',con_desc = '%s'") % (
                self.con_id,
                self.con_addr,
                self.node_ip,
                self.user_name,
                self.con_app,
                self.desc,
        )

class UserGroupDB(Base):
    __tablename__ = 'usergroup'
    id = Column(String(20),primary_key=True)
    name = Column(String(32))
    def __repr__(self):
        return ("<UserGroup(UserGroup='%s')") % (
            self.name
        )

class UserDB(Base):
    __tablename__ = 'user'
    id = Column(Integer,primary_key=True)
    name = Column(String(32))
    password = Column(String(32))
    user_group = Column(String(20),ForeignKey(UserGroupDB.id))
    is_active = Column(String(32),default=True)

    def __repr__(self):
        return ("<User( name = '%name',UserGroup = '%s',is_active = '%s')") %(
            self.name,
            self.user_group,
            self.is_active
        )

if __name__ == "__main__":
    Base.metadata.create_all(engine)
