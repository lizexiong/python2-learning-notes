# -*- coding: utf-8 -*-

import tornado.ioloop
import tornado.web
from . import pag


SHUJU = [
    {"user":"lgx","email":"729088188@qq.com"}
]
for f in range(300):
    SHUJU.append({"user": f, "email": "729088188@qq.com"})    #填充数据到300条



class indexHandler(tornado.web.RequestHandler):
    def get(self, page):

        paging = pag.paging(page,SHUJU,10,11,5,'/index/')

        if paging.cur_page > paging.number_of_total_pages:      #判断分页对象里的当前页码如果大于总页码
            total_page = str(paging.number_of_total_pages)      #将总页码转换成字符串
            self.redirect("/index/" + total_page)              #跳转到总页码
        else:
            # 显示index.html文件，传递当前页码，传递数据，传递分页
            self.render("index.html",cur_page=paging.cur_page,data=paging.scope_of_data(),show_page=paging.display_page_numbers())

    def post(self,page):
        user = self.get_argument("user")
        email = self.get_argument("email")
        temp = {"user":user,"email":email}
        SHUJU.append(temp)
        self.redirect("/index/" + page)
