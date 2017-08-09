import MySQLdb
conn = MySQLdb.connect(host='192.168.100.50',user='root',passwd='',db='host')
cur = conn.cursor(cursorclass = MySQLdb.cursors.DictCursor)


class Foo:

    def __init__(self, name):
        self.name = name

    @classmethod
    def select_sql(self):
        sql_select = cur.execute('select * from host.host_list')
        reslut = cur.fetchall()
        return reslut

result = Foo.select_sql()

