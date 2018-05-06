# -*- coding: utf-8 -*-



from model.node import NodeInfo


class pag(object):
    def __init__(self,cur_page,total_data_num,data_num,page_num,front_back_page,url):
        #cur_page,当前页
        #total_data_num, 所有数据的总条数
        #data_num, 一个分页显示多少条数据
        #page_num, 分页码总共显示多少
        #front_back_page, 显示当前页码前几个和后几个页码，需要结合每页显示多少个页码计算
        #url, 分页连接url后缀，也就是路由映射的后缀
        try:
            cur_page = int(cur_page)
        except:
            cur_page = 1
            #如果初始的时候,页数为负数,那么就是第一页
            if cur_page < 1:
                cur_page = 1

        self.cur_page = cur_page
        self.total_data_num = total_data_num
        self.data_num = data_num
        self.page_num = page_num
        self.front_back_page = front_back_page
        self.url = url

        #计算总页码
        number_of_total_pages, remainder = divmod(int(self.total_data_num),self.data_num) #数据总量除以显示条数,取余
        if remainder > 0: #判断如果余数大于0,那么肯定还要用多一页来显示
            number_of_total_pages += 1
        self.number_of_total_pages = number_of_total_pages

    def page_info(self):
        data = {'total_data_num':self.total_data_num,'number_of_total_pages':self.number_of_total_pages}
        return data

    def scope_of_data(self):
        '''
        返回每个数据范围要显示的这页的数据
        :return:
        '''
        start = (self.cur_page - 1) * self.data_num  #比如当前也是5-1 * 每页显示数据8  那么数据就是32
        end = self.cur_page * self.data_num    #比如当前页是5 * 每页显示数据8    那么数据就是40
        #show = self.total_data[start:end]       #把起始位置和结束位置传到数据库取这一段的数据
        show = NodeInfo.con_usage_info(start,end=self.data_num) #这里end-1是数据库limit的语法从0开始的
        print (start,end,'---',len(show))
        return show

    def display_page_numbers(self):

        '''
        本节代码逻辑
            if 现有数据的总页码(2)   < 一页要显示多少页码(10)
                    只能显示2页

            else (就是大于一页显示10页页码)
                    if当前页面(4)   <=  前后各显示多少页(5)
                        那么肯定是起始页肯定是1，结束页码为一个页面能显示的总页码
                    else (当前页面12,那么可以从7-17显示)
                        if  当前页面(12) + 前后页面(5)  >  现有数据总页码(13)
                            那么起始页 = 现有数据总页码(13) - (一页显示多少页码(10)-1) =4
                            结束页 = 现有数据总页码(13)
                        else 那么就是正常情况，当前页面(12) + 前后页面(5) < 现有数据总页码 (20)
                            起始页 = 当前页面-前后显示页面
                            结束也 = 当前页面+前后显示页面
        '''

        # 计算每页显示多少个页码
        # 假设每页显示11个页码，当前页的前5个和后5个
        # 所以需要动态调整循环里的值
        if self.number_of_total_pages <= self.page_num:
        #判断总页码小于每页显示多少个页码,如果总页码只有5个,你却要显示10个,那么也只能显示5个
            start = 1                           #起始页码为1
            end = self.number_of_total_pages                 #结束页码为总共有多少页码
        else:
            if self.cur_page <= self.front_back_page:
                #判断当前页码小于前后页码数,如果当前也为4,你前后要显示5个,那么往左边的起始页肯定没有-1，最少就是1
                start = 1                       #起始页码为1
                end = self.page_num             #结束页码为总页码
            else:
                #判断当前页码+前后页码大于总页码，如果当前页码为7，前后页码为5，总页码为10,那么起始页码应该是
                # 10  - （每页显示多少页码(10-1)） ,那么起始页码为1 当前页码为7 结束页码为10
                if (self.cur_page + self.front_back_page) > self.number_of_total_pages:
                    start = self.number_of_total_pages - (self.page_num - 1)
                    end = self.number_of_total_pages
                else:
                    #那么就正常计算之后显示
                    start = self.cur_page - self.front_back_page
                    end = self.cur_page + self.front_back_page

        #存储页码连接的字典
        page_list = []

        #首页
        home_page = '<li><a href="%s1">首页</a></li>' %(self.url)
        page_list.append(home_page)

        #上一页
        if self.cur_page <= 1:
            previous_page = '<li><a href="javascript:void(0);">上一页</a></li>'
            page_list.append(previous_page)
        else:
            previous_page = '<li><a href="%s%s">上一页</a></li>' %(self.url,self.cur_page-1)
            page_list.append(previous_page)

        #循环页数
        for i in range(start,end + 1):  #为了循环最后一页,所以end + 1                 # 根据分页总量循环次数
            if i == self.cur_page:
                temp = '<li class="active"><a href="%s%s">%s</a></li>' % (self.url,i, i)   # 格式化当前页码设置样式
            else:
                temp = '<li><a href="%s%s">%s</a></li>' % (self.url,i, i)               # 格式化当前页码
            page_list.append(temp)                                             # 将格式化的页码数据追加到列表

        #下一页
        if self.cur_page >= self.number_of_total_pages:
            next_page = '<li><a href="javascript:void(0);">下一页</a></li>'
            page_list.append(next_page)
        else:
            next_page = '<li><a href="%s%s">下一页</a></li>' %(self.url,self.cur_page+1)
            page_list.append(next_page)

        #尾页
        end_page = '<li><a href="%s%s">尾页</a></li>' % (self.url,self.number_of_total_pages)
        page_list.append(end_page)

        #跳转
        # skip = '<li class="btn btn-default"><input type="text" onclick="print()"/>跳转</li>'
        skip ='<form style="margin:0px;display:inline;"><input type="text" name="page" style="width:25px;height:32px;text-align:right;" /><input type="submit"  value="跳转" /></form>'
        page_list.append(skip)

        xian_shi = "\n".join(page_list)
        return xian_shi                                             # 将页面数据，连接成一个字符串，传输到HTML模板