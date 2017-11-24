# -*- coding: utf-8 -*-
import sys

import tornado.web

from docker_auto.settings import COOKIE_NAME,template_variables

sys.path.append("..")
from docker_auto.model.user import UserSqlOperation


class BaseHandler(tornado.web.RequestHandler):

    def get_current_user(self):
        template_variables["username"] = self.get_secure_cookie(COOKIE_NAME)
        print (self.get_secure_cookie(COOKIE_NAME))
        return self.get_secure_cookie(COOKIE_NAME)

    def check_authenticated(self):
        user_name = self.get_secure_cookie(COOKIE_NAME)
        mysql_adm_password = UserSqlOperation.check_adm_login(user_name)
        user_group = mysql_adm_password[0][2]
        if user_group != 'admin':
            self.redirect("/")