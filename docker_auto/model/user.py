# -*- coding: utf-8 -*-

from settings import DATABASES
from .mysql_server import MysqlServer


class UserSqlOperation(object):
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