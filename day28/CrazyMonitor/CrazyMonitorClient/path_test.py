#--*-- coding:utf8 --*--

#BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

#import os

#BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

#print BASE_DIR

import urllib,urllib2,time

# for i in range(1,10):
#     print i
#     req = urllib2.Request("http://211.136.163.68:8000/httpserver?enterpriseid=00323&accountid=666&pswd=4Y3j78z2&mobs=18101885773&msg=gongqigangsb%s"%(i))
#     respone = urllib2.urlopen(req)
#     the_page = respone.read()
#     print the_page
#     time.sleep(5)

url = 'http://www.someserver.com/cgi-bin/register.cgi'
values = {'name' : 'Michael Foord',
          'location' : 'Northampton',
          'language' : 'Python' }
data = urllib.urlencode(values)
req = urllib2.Request(url, data)
response = urllib2.urlopen(req)
the_page = response.read()

print the_page