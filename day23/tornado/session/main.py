#!/usr/bin/env python
# -*- coding:utf-8 -*-
  
import tornado.ioloop
import tornado.web
from hashlib import sha1
import os, time

#生成一个字典保存cookie以及用户是否已经有了登录的值
session_container = {}

#创建一个随机数当作cookie_id
create_session_id = lambda: sha1('%s%s' % (os.urandom(16), time.time())).hexdigest()

class Session(object):
  
    session_id = "session_cookie"
# 4.这里的构造方法，当请求来的时候应该现在浏览器找一找有没有session,
    def __init__(self, request):
        session_value = request.get_cookie(Session.session_id)
        print session_value
# 5如果没有就创建一个随机字符串
        if not session_value:
            self._id = create_session_id()
        else:
#6 否则直接将客户端的随机字符串设置为_id
            self._id = session_value
#7.然后设置cookie
        a = request.set_cookie(Session.session_id, self._id)
        print a
    def __getitem__(self, key):
        #额外注释，由于可能没有登录，是没有self.id值，那么就会报错，所以这里要异常处理。
        ret = None
        try:
            ret = session_container[self._id][key]
        except Exception, e:
            pass
        return ret

    def __setitem__(self, key, value):
        if session_container.has_key(self._id):
            session_container[self._id][key] = value
        else:
            session_container[self._id] = {key: value}
  
    def __delitem__(self, key):
        del session_container[self._id][key]
  
  
class BaseHandler(tornado.web.RequestHandler):
    """
        2.当请求到来之后首先会执行initialize这个方法，这个方法是固定写法
        那么在initialize这里可以获取用户的cookie和写cookie都可以在这里扩展了
        这里self是谁？  如果 obj = LoginHandler() ，那么执行obj.initialize方法，
        loginHandler里面没有initialize，但是它的父类里面有，所以self就等于obj，就等于loginHandler这个对象
    """
    def initialize(self):
        #这里就是tornado的自定义的方式

        # my_session['k1']访问 __getitem__ 方法
        """
        3 这里注意，Session(self)，因为Session是个类，那么执行的就是Session的构造方法，传入的是loginHandler对象
        由于LoginHandler有set_cookie对象，那么这里self也有set或者getcookie对象的方法
        那么看看Session做了什么
        """
        self.my_session = Session(self)

class MainHandler(BaseHandler):
    def get(self):
        #6. index判断是否有了登录状态，那么就进行if处理
        ret =  self.my_session['is_login']
        print ret,'----'
        if ret:
            self.write('index')
        else:
            self.redirect('/login')
#1 .LoginHandler继承了BaseHandler，BaseHandler继承了MainHandler
class LoginHandler(BaseHandler):
  
    def get(self):
        self.render('login.html')
  
    def post(self, *args, **kwargs):
  
        username = self.get_argument('username')
        password = self.get_argument('pwd')
        if username == 'lizexiong' and password == '123':
            """
            5.当post请求过来之后，通过验证后，那么我就可以设置islogin = true,并且保存在字典里面,
            并且重定向到index界面，那么index收到请求，现在去index的函数处理查看
            self.my_session['is_login'] = True 会执行Session类的__setitem__方法，
            因为这里传入了2个值，根据类的原理，会指定执行Session的__setitem__方法，
            还有，因为self.my_session = Session()，所以能够执行__setitem__方法
            """
            self.my_session['is_login'] = True
  
            self.redirect('/index')
        else:
            self.render('login.html')
  
settings = {
    'template_path': 'template',
    'static_path': 'static',
    'static_url_prefix': '/static/',
    'cookie_secret': 'aiuasdhflashjdfoiuashdfiuh',
    'login_url': '/login'
}
  
application = tornado.web.Application([
    (r"/index", MainHandler),
    (r"/login", LoginHandler),
], **settings)

if __name__ == "__main__":
    application.listen(8888)
    tornado.ioloop.IOLoop.instance().start()














