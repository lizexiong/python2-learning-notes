# -*- coding: utf-8 -*-

from django import forms
class IPCalculate(forms.Form):

    GROUP_LIST =(
        (1,'idc'),
        (2,'909')
    )

    group = forms.IntegerField(
        widget=forms.Select(attrs={'class':'select'},choices=GROUP_LIST)
    )