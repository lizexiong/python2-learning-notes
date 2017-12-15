# -*- coding: utf-8 -*-

import logging
import pymysql
pymysql.install_as_MySQLdb()
from DBUtils.PooledDB import PooledDB

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)




class MysqlServer(object):

    __pool = None
    def __init__(self,db_config):
        try:
            self.db_config = db_config
            self._conn = self.__get_conn()
            self._cursor = self._conn.cursor()
            logger.info(u"connected the db")
        except Exception:
            self.close()
            logger.exception(u"connect db failed!")

    def __get_conn(self):
        db_config = self.db_config
        try:
            poll = PooledDB(creator=pymysql, mincached=1,maxcached=30, host=db_config['HOST'],
                                         port=db_config['PORT'], user=db_config['USERNAME'],passwd=db_config["PASSWORD"],
                                         db=db_config['DB'],charset='utf8')
            connection = poll.connection()
        except Exception as e:
            import sys
            sys.exit(e)
        return connection

    # def ensure_cursor(self):
    #     if not self._cursor:
    #         if not self._conn:
    #             self._conn = self.__get_conn()
    #         self._cursor = self._conn.cursor()

    def run_sql(self,sql):
        self._cursor.execute(sql)
        #commit只对innodb生效，不加commit的话，修改数据库记录的操作不会生效。而如果是myisam引擎的话，不需要commit即可生效
        self._conn.commit()
        self.close()
        return self._cursor.fetchall()

    def close(self,):
        if self._cursor:
            self._cursor.close()
        if self._conn:
            self._conn.close()
        logger.info(u"closed the db connection")