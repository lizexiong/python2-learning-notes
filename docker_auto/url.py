# -*- coding: utf-8 -*-
from docker_auto.handler.user import Login,Logout
from docker_auto.handler.node import Main,Top,LeftGroup,NodeManage,ConManage,GroupList,ConModify,RightNode, \
                                        ConCreate,ConAction,ConStart,ConStop,ConRestart,ConDestory

urls = [
    (r"/", Login),
    (r"/login", Login),
    (r"/logout", Logout),
    (r"/main", Main),
    (r"/base",          Top),
    (r"/leftgroup",     LeftGroup),
    (r"/nodemanage", NodeManage),
    (r"/conmanage",     ConManage),
    # (r"/rightgroup",    RightGroup),
    (r"/grouplist",     GroupList),
    (r"/conmodify",     ConModify),
    (r"/node",          RightNode),
    (r"/concreate",     ConCreate),
    (r'/conaction',     ConAction),
    (r'/constart',      ConStart),
    (r'/constop',        ConStop),
    (r'/conrestart',      ConRestart),
    (r'/condestroy',      ConDestory)
]

