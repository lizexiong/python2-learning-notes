# -*- coding: utf-8 -*-

import scrapy
from scrapy.http import Request
from scrapy.selector import HtmlXPathSelector
import re
import urllib
import os

class XiaoHuaSpider(scrapy.spiders.Spider):
    name = 'xiaohuar'
    allowed_domains = ['xiaohuar.com']
    start_urls = [
        "http://www.xiaohuar.com/list-1-0.html",
    ]

    def parse(self,response):
        #请求的url
        current_url = response.url
        #原生的html内容
        body = response.body
        #把内容转换成unicode格式
        unicode_body = response.body_as_unicode()

        #然后不断递归下载获取响应值

         # 分析页面
        # 找到页面中符合规则的内容（校花图片），保存
        # 找到所有的a标签，再访问其他a标签，一层一层的搞下去

        #格式化html源码
        hxs = HtmlXPathSelector(response)
        # 如果url是 http://www.xiaohuar.com/list-1-\d+.html
        if re.match('http://www.xiaohuar.com/list-1-\d+.html',response.url):
            #支持链式编程，比如找到div[@class='xxx']的标签，或者div[@class='xxx']/a ,那么就是div下面的a标签
            items = hxs.select('//div[@class="item_list infinite_scroll"]/div')
            for i in range(len(items)):
                """
                //div[@class="item_list infinite_scroll"]/div[%d]//div[@class="img"]/a/img/@src
                为什么这么写？首先找到class为item_list infinite_scroll的div，这个div 下面还有很多div，就是
                div[@class="item_list infinite_scroll"]/div[%d] ，因为这个div下面还有很多div，所以这里使用for循环
                div[@class="item_list infinite_scroll"]/div[%d]//div[@class="img"]   这里第二次使用了//，因为这个单独
                的div下面还有自己的属性，格式就不固定了，但是到第二个div的时候格式都还是一样的。
                然后根据下面的标签找到自己想要的值

              """
                src = hxs.select('//div[@class="item_list infinite_scroll"]/div[%d]//div[@class="img"]/a/img/@src' % i).extract()
                name = hxs.select('//div[@class="item_list infinite_scroll"]/div[%d]//div[@class="img"]/span/text()' % i).extract()
                school = hxs.select('//div[@class="item_list infinite_scroll"]/div[%d]//div[@class="title"]/span/a/text()' % i).extract()
                if src:
                    #因为src没循环一次都是一个链接，但是链接是放在列表里面的
                    ab_src = "http://www.xiaohuar.com" + src[0]
                    # file_name = "%s_%s.jpg" %(school[0].encode('utf-8'),name[0].encode('utf-8'))
                    file_name = "%s_%s.jpg" %(school[0],name[0])
                    file_path = os.path.join('./scrapyimg',file_name)
                    #这里是urllib的一个方法，类始于文件另存为
                    urllib.urlretrieve(ab_src,file_path)

        #找到  整个下面 页面的a 标签，取出里面href属性的值，为就是网页连接，
        all_urls = hxs.select('//a/@href').extract()
        for url in all_urls:
            #这里做了一个限制，因为all_urls会有很多超链接出来，这里只递归我们需要的连接，使用startswith来匹配以我们需要的开头的
            if url.startswith("http://www.xiaohuar.com/list-1-"):
                #这里只要记住，出现了yield就是要开始将自己进行递归了。
                yield Request(url,callback=self.parse)












