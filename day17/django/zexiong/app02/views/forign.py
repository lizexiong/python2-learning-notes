#!/usr/bin/env python
#encoding:utf-8

from django.shortcuts import render,render_to_response,HttpResponse
from app02 import models

def create_group(request):
    models.Group2.objects.create(caption='CEO')
    models.Group2.objects.create(caption='CTO')
    models.Group2.objects.create(caption='COO')
    return HttpResponse('create success')

