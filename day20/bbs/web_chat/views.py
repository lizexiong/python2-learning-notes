# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.shortcuts import render

# Create your views here.

def dashboard(request):
    return render(request,'web_chat/dashboard.html')