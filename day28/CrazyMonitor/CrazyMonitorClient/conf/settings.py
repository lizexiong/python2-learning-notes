# -*- coding: utf-8 -*-

configs = {
    'HostId':1,
    "Server":"localhost",
    "ServerPort":9000,
    "urls":{

        'get_configs':['api/client/config','get'],
        'service_report':['api/client/service/report/','post'],
    },
    'RequestTimeout':30,
    'ConfigUpdateInterval':300,
}