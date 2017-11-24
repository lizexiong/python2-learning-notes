# -*- coding: utf-8 -*-

import os

import tornado.web

from docker_auto.url import urls

PORT = 8888
SETTINGS = dict(
    template_path = os.path.join(os.path.dirname(__file__),  "templates"),
    static_path = os.path.join(os.path.dirname(__file__), "static"),
    login_url = "/login",
    cookie_secret="235lksjfASKJFlks=jdfGLKS=JDFLKSsfjlk234dsjflksdjffj/=sf"
)

application = tornado.web.Application(
    handlers=urls,
    **SETTINGS
)


