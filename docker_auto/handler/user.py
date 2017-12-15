# -*- coding: utf-8 -*-

from handler.base import BaseHandler
from model.check import Check
from settings import COOKIE_NAME

class Login(BaseHandler):
    def get(self,*args,**kwargs):
        self.render("users/login.html",login_strings=dict(username="Email",password="Password"))

    def post(self,*args,**kwargs):
        input_username = self.get_argument("username")
        input_password = self.get_argument("password")
        # print (input_username)
        check_result = Check.login_check(input_username,input_password)
        if check_result == "Invalid username":
           self.render("users/login.html",login_strings=dict(username="Invalid username",password='Password'))
        elif check_result == "Incorrect password":
            self.render("users/login.html",login_strings=dict(username="Email",password="Incorrect password"))
        elif check_result == "1":
            self.set_secure_cookie(COOKIE_NAME,input_username,expires_days=1)
            self.redirect("/main")
        else:
            self.set_secure_cookie(COOKIE_NAME,input_username,expires_days=1)
            self.redirect("user/login.html")

class Logout(BaseHandler):
        def get(self, *args, **kwargs):
            self.clear_cookie(COOKIE_NAME)
            self.write("<script language='javascript'>top.window.location.href='/';</script>")
