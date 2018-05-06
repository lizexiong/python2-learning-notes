# -*- coding: utf-8 -*-
from handler.user import Login,Logout,Register,MailVerifcation,UserReset
from handler.node import Main,Top,LeftGroup,NodeManage,ConManage,GroupList,ConModify,RightNode, \
                                        ConCreate,ConAction,ConStart,ConStop,ConRestart,ConDestory,NodeAdd, \
                                        NodeModify,GroupGraph,MultiContainerOperation
# from handler.node_ajax import pag

from handler.node_ajax import NodeManageHostStatus

urls = [
    (r"/", Login),
    (r"/login", Login),
    (u'/register',Register),
    (u'/userreset',UserReset),
    (u'/mailverifcation',MailVerifcation),
    (r"/logout", Logout),
    (r"/main", Main),
    (r"/base",          Top),
    (r"/leftgroup",     LeftGroup),
    (r"/nodemanage", NodeManage),
    #(r"/nodemanage/(?P<page>\d*)", NodeManage),
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
    (r'/condestroy',      ConDestory),
    (r'/nodeadd',           NodeAdd),
    (r'/nodemodify',        NodeModify),
    (r'/nodemanagehoststatus',NodeManageHostStatus),
    (r'/groupgraph',GroupGraph),
    (r'/multicontaineroperation',MultiContainerOperation)
    # (r'/pag',pag),
]

