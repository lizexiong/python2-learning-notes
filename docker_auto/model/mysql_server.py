# -*- coding: utf-8 -*-


import logging
import pymysql
pymysql.install_as_MySQLdb()
from DBUtils.PooledDB import PooledDB


'''
logging中可以选择很多消息级别，如debug、info、warning、error以及critical。
通过赋予logger或者handler不同的级别，开发者就可以只输出错误信息到特定的
记录文件，或者在调试时只记录调试信息。

__name__就是本程序自己,只显示info以上的信息
https://www.cnblogs.com/zhbzz2007/p/5943685.html

'''
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


'''
	pymysql操作顺序
		1.打开数据库连接。
		2.生成一个游标
		3.用生成的游标去操作sql动作

'''

class MysqlServer(object):
    '''连接数据库服务器'''

    def __init__(self,db_config):
        try:
			#数据库配置文件
            self.db_config = db_config
			#打开数据库连接
            self._conn = self.__get_conn()
			#用打开的数据库连接生成一个游标
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

    #执行sql语句
    def run_sql(self,sql):
        self._cursor.execute(sql)
        #commit只对innodb生效，不加commit的话，修改数据库记录的操作不会生效。而如果是myisam引擎的话，不需要commit即可生效
        self._conn.commit()
        return self._cursor.fetchall()

    #执行sql语句,但不需要返回结果，如更新数据库等操作
    def execute_sql(self,sql):
        self._cursor.execute(sql)
        self._conn.commit()

    #执行sql语句，只需要返回结果
    def run_sql_fetchone(self,sql):
        self.ensure_cursor()
        self._cursor.execute(sql)
        return self._cursor.fetchall()

    def close(self):
        if self._cursor:
            self._cursor.close()
        if self._conn:
            self._conn.close()
        logger.info(u"closed the db connection")