#!/usr/bin/env python
#--*-- coding:utf-8 --*--

from django import template
register =template.Library()
from django.utils.safestring import mark_safe

@register.simple_tag
def page_test():
    html = "<p style='font-size:10px'>" + '111' + "</p>"
    return html


def tree_search(com_dic,comment_obj):
    for i,j in com_dic.items():
        if i == comment_obj.parent_comment:
            com_dic[i][comment_obj] = {}
            return
        else:
            tree_search(com_dic[i],comment_obj)

comment_dic = {}

def generate_comment_html(sub_comment_dic,margin_left_val):
    html = ""
    #4那么这里就是取出第二级评论，这时就要缩进了
    for i,j in sub_comment_dic.items():
        html += "<div style='margin-left:%spx' class='comment-node'>" %margin_left_val + i.comment + "</div>"
    #5.如果字典往下还有值还有递归的话，那么把剩下的船进入在次判断,然后还是需要缩进。
        if j:
            html += generate_comment_html(j,margin_left_val+15)
    #6然后将所有拼接的html返回回去
    return html


@register.simple_tag
def build_comment_tree(comment_list):
    # print comment_list
    for comment_obj in comment_list:
        # print "parent----",i.parent_comment
        # print "son----",i.comment
        #i现在是一个对象，包含了parent和son
        if comment_obj.parent_comment is None:
            comment_dic[comment_obj] ={}
        else:
            tree_search(comment_dic,comment_obj)


    #1.首先定义一个初始html
    html = "<div class='comment-box'>"
    margin_left = 10
    for i,j in comment_dic.items():
        #2这里是第一级评论，最高评论
        html += "<div class='comment-node'>" + i.comment + "</div>"
        '''
        3 如果第一及评论展示完了，那么就是递归找评论了,
        那么就要把字典剩下的船进入，也就是j，然后子及评论应该缩进，所以margin_left
        参数就要+10,然后generate_comment_html查找完毕后将值返回回来和总的html相加
        7 这里其实也是第7步，所有的值都返回回来，然后在返回给前端
        '''
        html += generate_comment_html(j,margin_left+10)
    html += "</div>"
    return mark_safe(html)

