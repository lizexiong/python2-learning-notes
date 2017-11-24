# -*- coding: utf-8 -*-


import tornado.web
import tornado.ioloop
from hashlib import sha1
import os,time


#创建一个随机的加密字符串
create_session_id = lambda: sha1('%s%s' % (os.urandom(16), time.time())).hexdigest()

session_container = {}

class Session(object):
    session_id = "__sessionId__"

    def __init__(self,request):

        session_value = request.get_cookie(Session.session_id)
        print session_value
        if not session_value:
            self._id  = create_session_id()
        else:
            self._id  = session_value
        request.set_cookie(Session.session_id,self._id)

    def __getitem__(self, key):
        ret = None
        try:
            return session_container[self._id][key]
        except Exception, e:
            pass
        return ret

    def __setitem__(self, key, value):
        if session_container.has_key(self._id):
            session_container[self._id][key] = value
        else:
            session_container[self._id] = {key:value}

    def __delitem__(self,key):
        if session_container.has_key(self._id):
            del session_container[self._id][key]

#3,我们这里集成tornado.web.RequestHandler这个类，本来是MainHandler集成的，但是为了扩展，我们中间多来个类
class BaseHandler(tornado.web.RequestHandler):
    def initialize(self):
        # my_session['k1']  自动   访问 __getitem__ 方法
        #4.就是这里定义session处理，在每个class执行之前
        self.my_session = Session(self)


#2根据url找到处理的函数，这里继承了BaseHandler，里面有个initialize，就是在这里做我们的扩展
class MainHandler(BaseHandler):
    def get(self):
        ret = self.my_session['is_login']
        print ret,'----'
        if ret:
            self.write("ok")
            del self.my_session['is_login']
            print self.my_session['is_login']
        else:
            self.render('login.html')

class LoginHandler(BaseHandler):
    def get(self):
        self.render('login.html')
    def post(self):
        username = self.get_argument('username')
        password = self.get_argument('pwd')
        if username == 'lizexiong' and  password == '123':
            self.my_session['is_login'] = True
            self.redirect('/index')
            print 'login success..'
        else:
            self.render('login.html')


settings = {
    'template_path': 'template',
    'static_path': 'static',
    'static_url_prefix': '/static/',
    'cookie_secret': 'aiuasdhflashjdfoiuashdfiuh',
    'login_url': '/login'
}

#1.路由系统，根据url找到处理的函数
application = tornado.web.Application([
    (r"/index",MainHandler),
    (r"/login",LoginHandler),
],**settings)


if __name__ == '__main__':
    application.listen(8888)
    tornado.ioloop.IOLoop.instance().start()
