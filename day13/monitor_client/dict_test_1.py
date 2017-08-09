#!/usr/bin/evn python
#--*-- coding:utf-8 --*--
"""
    本章只要联系字典和列表嵌套取值，首先第一个循环，然后思路是从分叉的地方开始独立，
    如threading，后面包含了字典，其它就是一个单值，所以，首先把threading值先拿出来，然后在一步一步来。
"""


config = {
        "load" : {
            "last_time":0,
            "interval":10,
            "plugin_name":"get_load_info",
            "threading":{
                "load1":[
                    {"operator":"gt", "formula":None,"val":"0.1","test":[{"name":"lizexiong"}]},
                ],
                "load5":[
                    {"operator":"lt", "formula":None,"val":"0.1","complex":{"interval": 30, "times": 5,"has_times": 0, "relative_time": 0},"test":[{"name":"wuxinzhe"}]}
                ]
            }
        },
}

#"complex":{"interval": 30, "times": 5,"has_times": 0, "relative_time": 0}
for i, j in config.items():
    for ii,jj in j['threading'].items():
        for iii in jj:
            result = iii.get('test')
            if result:
                for iiii in result:
                    print iiii
                    for iiiii,jjjjj in iiii.items():
                        print iiiii,jjjjj
                    print iiii['name']