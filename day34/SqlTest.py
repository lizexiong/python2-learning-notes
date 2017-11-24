# -*- coding: utf-8 -*-


# from sqlalchemy import *
#
# engine = create_engine("mysql://root:huawei@192.168.100.1:3306/test",echo=True)
# metadata = MetaData()
#
#
# user = Table('user',metadata,
#              Column('id',Integer,primary_key=True),
#              Column('name',String(20)),
#              Column('fullname',String(50)),
# )
#
# address = Table('address',metadata,
#                 Column('id',Integer,primary_key=True),
#                 Column('user_id',None,ForeignKey('user.id')),
#                 Column('email',String(60),nullable=False)
#                 )
#
# metadata.create_all(engine)
#
# conn = engine.connect()
# i = user.insert()
#
# u = dict(name='zexiong',fullname='lizexiong')
# r =  conn.execute(i,**u)
# print r
# print (r.inserted_primary_key)


# i = user.insert().values(name='tom',fullname='tom Jim')
# print (i.compile())
# r = conn.execute(i)
# print (r.rowcount)


# s= select([user,])
# # print s
# r = conn.execute(s)
# print (r.rowcount)
#
# ru = r.fetchall()
# print (ru)


# s = select([user.c.name,address.c.user_id]).where(user.c.id==address.c.user_id)
# ss = conn.execute(s)
# print ss
# sss = ss.fetchall()
# print sss

# print (user.c.id == address.c.user_id)
# print (user.c.id == 7)


# text_sql = "select id , name ,fullname from user where id = :id"
# s = text(text_sql)
# print (conn.execute(s,id=2).fetchall())


# from docker.curl import Curl
#
# c = Curl('http://192.168.100.200:2375/containers/1e470ab1/json')
# d = c.get_value()
# print (d)
#

import docker
def images_list( node_ip, node_port):
    client_ins = docker.APIClient(base_url='tcp://' + node_ip + ':' + node_port, version='1.24', timeout=5)
    res_json = client_ins.images()
    images_list = []
    for i in res_json:
        images_list.append(i['RepoTags'])
    print (images_list)
    # client_ins.start()
#
# port = str("2375")
#
images_list('192.168.100.200','2375')

