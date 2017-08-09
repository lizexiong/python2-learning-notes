#!/usr/bin/evn python
#--*-- coding:utf-8 --*--

"""
1.in 这个方法不能随便用，比如，long就不能用，str类型就可以
"""

import MySQLdb,sys,threading,os

try:
    conn = MySQLdb.connect(host='192.168.100.50',user='root',passwd='',db='host')
    cur = conn.cursor(cursorclass = MySQLdb.cursors.DictCursor)

except Exception,i:
        print "Mysql connection Failed.."
        sys.exit(1)

class host_list(object):

    def __init__(self,id,hostname,host,port,username,password):
        self.id= id
        self.hostname = hostname
        self.host = host
        self.port = port
        self.username = username
        self.password = password

    @classmethod
    def select_sql(cls):
        sql_select = cur.execute('select * from host.host_list')
        result = cur.fetchall()
        # hostn = reslut[0]['hostname']
        # print hostn
        # for i in reslut:
        #     print str(i['id']),i['hostname'],i['host'],i['port'],i['username'],i['password']
        #     # print type(i['id']),type(i['hostname']),type(i['host']),type(i['port'])
        return result

    def add_host(self):
        host_add = cur.execute('insert into host_list(id,hostname,host,port,username,password) values(%s,%s,%s,%s,%s,%s)',(self.id,self.hostname,self.host,self.port,self.username,self.password))
        conn.commit()
        return host_add

    def update_host(self):
        host_update = cur.execute('update host_list set hostname=%s,host=%s,port=%s,username=%s,password=%s where id =%s',(self.hostname,self.host,self.port,self.username,self.password,self.id))
        conn.commit()
        return host_update

    @classmethod
    def delete_host(cls,d_id):
        host_delete = cur.execute('delete from host_list where id =%s'%d_id)
        return host_delete

    @classmethod
    def close_host(cls):
        cur.close()
        conn.close()

def user_input():
        global id_user,hostname_user,host_user,port_user,username_user,password_user
        id_user = raw_input('Please enter your host ID').strip()
        id_user = long(id_user)
        hostname_user = raw_input('Please enter your host name')
        host_user = raw_input('Please enter your host IP')
        port_user = raw_input('Please enter your host port')
        username_user = raw_input('Please enter your hostname user name')
        password_user = raw_input('Please enter your host user password')


def run():

    msg = """
*********************************************************************
            Welcome to XunNuo fortress management system V1.0

            1. Input 1 view the list of hosts
            2. Enter 2 to increase the host
            3. Enter 3 to update host information
            4. Enter 4 to remove the host
            5. Connect to remote host....
            6. quit,quit the system
*********************************************************************
"""
    print ('\033[1;34m%s\033[1m'%msg)
    while True:
        a = raw_input("Please enter your operation options serial number:(num)")
        if a == '1':
            s_result=host_list.select_sql()
            host_dict = {}
            for i in s_result:
                host_ = str(i['id']),i['hostname'],i['host'],i['port'],i['username'],i['password']
                # print host_
                print ('\033[1;35m%s  %s  %s  %s  %s  %s\033[1m'%host_)
                # print type(i['id']),type(i['hostname']),type(i['host']),type(i['port'])
                host_dict[i['hostname']] = i['host']


        elif a == '2':
            user_input()
            s_result = host_list.select_sql()
            id_list = []
            for i in s_result:
                id_list.append(i['id'])
            if id_user in id_list:
                print "Host in List"
            else:
                # print id,type(id),i['id'],type(i['id'])
                obj_add = host_list(id_user,hostname_user,host_user,port_user,username_user,password_user)
                result_add = obj_add.add_host()
                print "Add liner",result_add

        elif a == '3':
            user_input()
            s_result = host_list.select_sql()
            u_list = []
            for i in s_result:
                u_list.append(i['id'])
            if id_user in u_list:
                obj_update = host_list(id_user,hostname_user,host_user,port_user,username_user,password_user)
                result_update = obj_update.update_host()
                print "Update line",result_update
            else:
                 print "Not is Host"

        elif a == '4':
                d = raw_input("Please delte id")
                host_list.delete_host(d)

        elif a == '5':
            ssh_host = host_list.select_sql()
            host_dict = {}
            for i in ssh_host:
                host_dict[i['hostname']] = i['host']

            while True:
                for hostname,ip in host_dict.items():
                    print hostname,ip
                try:
                    host = raw_input("Please input your host:").strip()
                    if host == 'quit':
                        print "Bye"
                        break
                except KeyboardInterrupt: sys.exit(0)
                except EOFError:sys.exit(0)
                if len(host)==0:continue
                if not host_dict.has_key(host):
                    print "Not host"
                    continue
                print '\033[32;1m Connect to ... \033[0m',host_dict[host]
                os.system("python demo.py %s"%host_dict[host])


        elif a == 'quit':
            host_list.close_host()
            sys.exit(0)

        else:
            continue
t = threading.Thread(target=run,)
t.start()








