# -*- coding: utf-8 -*-


class paging(object):
    def __init__(self,cur_page,total_data,data_num,page_num,front_back_page,url):
        # cur_page ,当前页
        # total_data ,接收分页数据列表
        # data_num 接收每页显示多少条数据
        # page_num 每页显示多少个页码
        # front_back_page,显示当前页码前几个和后几个页码，需要结合每页显示多少个页码计算
        #url,分页连接url后缀，也就是路由映射的后缀
        try:
            cur_page = int(cur_page)
        except:
            cur_page = 1
        if cur_page < 1:
            cur_page = 1

        self.cur_page = cur_page
        self.total_data = total_data
        self.data_num = data_num
        self.page_num = page_num
        self.front_back_page = front_back_page
        self.url = url

        #计算总页码
        number_of_total_pages, remainder = divmod(len(self.total_data),self.data_num) #数据总量除以显示条数,取余
        if remainder > 0: #判断如果余数大于0,那么肯定还要用多一页来显示
            number_of_total_pages += 1
        self.number_of_total_pages = number_of_total_pages

    def scope_of_data(self):
        '''
        返回每页获取范围数据
        :return:
        '''
        start = (self.cur_page - 1) * self.data_num  #比如当前也是5-1 * 每页显示数据8  那么数据就是32
        end = self.cur_page * self.data_num    #比如当前页是5 * 每页显示数据8    那么数据就是40
        show = self.total_data[start:end]       #通过起始和结束位置以下标方式获取指定范围的列表数据
        return show

    def display_page_numbers(self):
        # 计算每页显示多少个页码
        # 假设每页显示11个页码，当前页的前5个和后5个
        # 所以需要动态调整循环里的值
        if self.number_of_total_pages < self.page_num: #判断总页码小于每页显示多少个页码，如果总页码只有5个，你却要显示10个，那么也只能显示5个
            start = 1                                   #起始页码为1
            end = self.page_num                         #结束页码为总页码
        else:
            if self.cur_page <= self.front_back_page + 1: #判断当前页码小于前后页码数,如果当前也为4,你前后要显示5个,那么往左边的起始页肯定没有-1，最少就是1
                start = 1                               #起始页码为1
                end = self.page_num                     # 结束页码为每页显示多少个页码
            else:
                #判断当前页码+前后页码大于总页码，如果当前页码为7，前后页码为5，总页码为10,那么其实页码应该是 10 - （每页显示多少页码(10-1)） ,那么其实页码为1 当前页码为7 结束页码为10
                if (self.cur_page + self.front_back_page) > self.number_of_total_pages:
                    start = self.number_of_total_pages - (self.page_num - 1)
                    end = self.number_of_total_pages
                else:
				#那么就正常计算之后显示
                    start = self.cur_page - self.front_back_page
                    end = self.cur_page + self.front_back_page

        page_list = []

        #首页
        sh_temp = '<li><a href="%s1">首页</a></li>' % (self.url)
        page_list.append(sh_temp)

        #上一页
        if self.cur_page <= 1:
            shye = '<li><a href="javascript:void(0);">上一页</a></li>'
            page_list.append(shye)
        else:
            shye = '<li><a href="%s%s">上一页</a></li>' %(self.url,self.cur_page-1)
            page_list.append(shye)


        for i in range(start, end + 1):                                               # 根据分页总量循环次数
            if i == self.cur_page:                                          # 判断循环到的页码等于当前页面
                temp = '<li class="yem"><a href="%s%s">%s</a></li>' % (self.url,i, i)   # 格式化当前页码设置样式
            else:
                temp = '<li><a href="%s%s">%s</a></li>' % (self.url,i, i)               # 格式化当前页码
            page_list.append(temp)                                             # 将格式化的页码数据追加到列表


        #下一页
        if self.cur_page >= self.number_of_total_pages:
            xye = '<li><a href="javascript:void(0);">下一页</a></li>'
            page_list.append(xye)
        else:
            xye = '<li><a href="%s%s">下一页</a></li>' %(self.url,self.cur_page+1)
            page_list.append(xye)

        #尾页
        wei_temp = '<li><a href="%s%s">尾页</a></li>' % (self.url,self.number_of_total_pages)
        page_list.append(wei_temp)

        xian_shi = "\n".join(page_list)                                        # 将页面数据，连接成一个字符串，传输到HTML模板
        return xian_shi


