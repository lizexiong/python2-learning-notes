


import paramiko
import os
import configparser


class ZabbixAgentInstall(object):
	def __init__(self,server_ip,agent_ip,agent_user,agent_passwd,url):
		self.server_ip = server_ip
		self.agent_ip = agent_ip
		self.agent_user = agent_user
		self.agent_passwd = agent_passwd
		self.url = url
		self.connect()

	def connect(self,):
		self.transport = paramiko.Transport(self.agent_ip, 22)
		self.transport.connect(username=self.agent_user, password=self.agent_passwd)
		self.ssh = paramiko.SSHClient()
		self.ssh._transport = self.transport
		self.sftp = paramiko.SFTPClient.from_transport(self.transport)

	def command(self,cmd):

		stdin, stdout, stderr = self.ssh.exec_command(cmd)
		#print (stdout.channel.recv_exit_status()) 
		result = stdout.read()
		return result

	def zabbix_agent_configmodify(self,config_file):
		if not os.path.exists(config_file):
			print ("config_file not exists")
			return False	
		else:
			real_hostname = self.command('hostname').strip()
			f = file(config_file,'rb+')
			# f.seek(0, 0)
			for line in f:
				print (line)
				if line.startswith('Server='):
					server = line.split('=')
					new_line = line.replace(server[1],self.server_ip)
					print (new_line)
					f.write(new_line)
				if line.startswith('ServerActive='):
					serveractive = line.split('=')
					new_line = line.replace(serveractive[1],self.server_ip)
					f.write(new_line)
				if line.startswith('Hostname='):
					hostname = line.split('=')
					new_line =line.replace(hostname[1],real_hostname)
					f.write(new_line)
			f.close()

	def put(self,):
		self.sftp.put('zabbix_agentd.conf','/tmp/zabbix_agentd.conf')

	def close(self):
		self.transport.close()


server_ip = '192.168.0.55'
agent_ip = '192.168.0.41'
agent_user = 'root'
agent_passwd = "root123"
rpm_cmd = "setenforce 0 ;rpm -ivh http://repo.zabbix.com/zabbix/3.4/rhel/6/x86_64/zabbix-release-3.4-1.el6.noarch.rpm ; yum -y install zabbix-agent"


obj = ZabbixAgentInstall(server_ip, agent_ip, agent_user, agent_passwd, rpm_cmd)
#obj.command(rpm_cmd)
obj.zabbix_agent_configmodify('zabbix_agentd.conf')
# obj.put()
#obj.command(rpm_cmd)

