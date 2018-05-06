# -*- coding: utf-8 -*-

from handler.base import BaseHandler
from model.check import Check
from model.user import UserSqlOperation
from settings import COOKIE_NAME

class Login(BaseHandler):
    def get(self,*args,**kwargs):
        self.render("users/login.html",login_strings=dict(username="Email",password="Password"))

    def post(self,*args,**kwargs):
        input_username = self.get_argument("username")
        input_password = self.get_argument("password")
        # print (input_username)
        check_result = Check.login_check(input_username,input_password)
        print (check_result,'---')
        if check_result == "Invalid username":
           self.render("users/login.html",login_strings=dict(username="Invalid username",password='Password'))
        elif check_result == "Incorrect password":
            self.render("users/login.html",login_strings=dict(username="Email",password="Incorrect password"))
        elif check_result == "1" or check_result == "2":
            self.set_secure_cookie(COOKIE_NAME,input_username,expires_days=1)
            self.redirect("/main")
        else:
            self.set_secure_cookie(COOKIE_NAME,input_username,expires_days=1)
            self.redirect("/login")

class Register(BaseHandler):
    def get(self,*args,**kwargs):
        self.render("users/Register.html")

    def post(self,*args,**kwargs):
        data_json = self.get_argument('data')
        data = eval(data_json)
        input_username = data['email']
        input_password = Check.md5(data['passwd'])
        # print ('useradd_ret',input_username,'passwd',input_password)
        useradd_ret = Check.user_register(input_username,input_password)
        if useradd_ret == "successfully added":
            self.write('successfully added')
        else:
            self.write("fail")

class MailVerifcation(BaseHandler):
    def post(self,*args,**kwargs):
        mail = self.get_argument('data',None)
        if mail is not None:
            check_res = Check.mail_check(mail)
            if check_res:
                self.write('exist')
            else:
                self.write('inexistence')
        else:
            self.write('no mailbox name')

class UserReset(BaseHandler):
    def get(self,*args,**kwargs):
        email_list = UserSqlOperation.mail_list()
        self.render("users/userreset.html",email_list=email_list)

    def post(self,*args,**kwargs):
        mail = self.get_argument('mail')
        passwd = Check.md5(self.get_argument('textfield2'))
        user_pwd_reset_ret = Check.user_pwd_reset(mail,passwd)
        self.write(user_pwd_reset_ret)


class Logout(BaseHandler):
        def get(self, *args, **kwargs):
            self.clear_cookie(COOKIE_NAME)
            self.write("<script language='javascript'>top.window.location.href='/';</script>")
