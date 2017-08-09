# -*- coding: utf-8 -*-
from django.shortcuts import render,HttpResponse

class mmm(object):
    def process_request(self,request):
        print "xxx.process_request"

    def process_view(self, request, callback, callback_args, callback_kwargs):
        print 'xxx.process_view'

    def process_response(self, request, response):
        print 'xxx.process_response'
        return response

    def process_exception(self, request, exception):
        return HttpResponse('上面哪个不管， 我来管')

class yyy(object):
    def process_request(self,request):
        print "yyy.process_request"

    def process_view(self, request, callback, callback_args, callback_kwargs):
        print 'yyy.process_view'

    def process_response(self, request, response):
        print 'yyy.process_response'
        return response

    def process_exception(self, request, exception):
        print "我没有return，我只在debug界面出现"