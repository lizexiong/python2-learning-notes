# -*- coding: utf-8 -*-

from settings import DATABASES
from .mysql_server import MysqlServer
import pymysql

class UserSqlOperation(object):
    @staticmethod
    def user_add(username,passwd):
        db = MysqlServer(DATABASES)
        sql = "insert into user(name,password,user_group) values('%s','%s',2) " %(username,passwd)
        try:
            ret = db.run_sql(sql)
        except pymysql.Error as e:
            db.close()
            return 'exist'
        db.close()
        return ret

    @staticmethod
    def user_pwd_reset(username,passwd):
        db = MysqlServer(DATABASES)
        print (username)
        sql = "update user set password='%s' where name='%s';" %(passwd,username)
        try:
            ret = db.run_sql(sql)
            print ("username",'passwd','ret',username,passwd,type(ret))
        except pymysql.Error as e:
            db.close()
            print (e)
            return 'error'
        db.close()
        return ret


    #通过类直接调用该函数
    @staticmethod
    def check_adm_login(admname):
        db = MysqlServer(DATABASES)
        sql = "select `name`,`password`,`user_group` from user where name='%s'" % admname
        ret = db.run_sql(sql)
        db.close()
        return ret

    @staticmethod
    def is_admin(user):
        db = MysqlServer(DATABASES)
        sql = "select user_group from user where name='%s'" %(user)
        ret = db.run_sql(sql)
        db.close()
        return ret

    @staticmethod
    def mail(mail):
        db = MysqlServer(DATABASES)
        sql = "select name from user where name='%s'" %(mail)
        ret = db.run_sql(sql)
        db.close()
        return ret

    @staticmethod
    def mail_list():
        db = MysqlServer(DATABASES)
        sql = "select name from user"
        ret = db.run_sql(sql)
        db.close()
        return ret