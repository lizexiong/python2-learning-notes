# -*- coding: utf-8 -*-

from django.conf.urls import url
from web_chat import views

urlpatterns = [
    #第二层的url不要加  ^  否则匹配不到，这是开头匹配的符号
    url(r'dashboard/$', views.dashboard,name='web_chat'),
    url(r'contacts/$',views.contacts,name='load_contact_list'),
    url(r'msg/$',views.new_msg,name='send_msg'),
    url(r'msg/$',views.new_msg,name='get_new_msgs'),
]
