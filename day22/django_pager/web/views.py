# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.shortcuts import render,HttpResponse
from web import models


# Create your views here.


class page(object):
    def __init__(self,current_page):
        self.current_page = int(current_page)

    @property
    def start(self):
        return int(self.current_page - 1) * 10

    @property
    def end(self):
        return int(self.current_page) * 10

    def page_str(self,all_item,base_url):
        all_page, div = divmod(all_item,10)
        if div > 0:
        #如果余数除以10还有剩下的，那么总页数还要加1展示剩下的内容
            all_page +=1
        page_list = []
        if all_page < 11:
            start = 1
            end = all_page
        else:
            if self.current_page < 6:
                start = 1
                end = 12
            else:
                start = self.current_page - 5
                end = self.current_page + 6
                if self.current_page + 6 > all_page:
                    start = self.current_page - 11
                    #这里加1是因为for循环的时候最后一个值不使用，所以要加1
                    end = all_page + 1
        for i in range(start,end):
            if i == self.current_page:
                temp = "<a style='color:red;font-size:25px;' href='%s%d'>%d</a>" %(base_url,i,i)
            else:
                temp = "<a href='%s%d'>%d</a>" %(base_url,i,i)
            page_list.append(temp)
        if self.current_page != 1:
            pre_page = "<a href='%s%d'>上一页</a>" %(base_url,self.current_page-1)
            page_list.insert(0,pre_page)
        if self.current_page != all_page:
            next_page = "<a href='%s%d'>下一页</a>" %(base_url,self.current_page+1)
            page_list.append(next_page)
        #列表转换为字符串
        return "".join(page_list)


def user_list(request):
    # for i in range(100,500):
    #     temp = {'username':"name%d" %i,'age':i}
    #     models.UserList.objects.create(**temp)
    #获取其前端URL的值
    current_page = int(request.GET.get('page',1))
    page_obj = page(current_page)
    result = models.UserList.objects.all()[page_obj.start:page_obj.end]

    #分页超链接
    all_item = models.UserList.objects.all().count()

    page_str = page_obj.page_str(all_item,'/user_list/?page=')
    return render(request,'user_list.html',{'result':result,'page_str':page_str})











