# -*- coding: utf-8 -*-

import tornado.ioloop
import tornado.web
from controllers import index


settings = {
    'template_path':'views',
    'static_path':'statics',
}

application = tornado.web.Application([
    (r"/index/(?P<page>\d*)",index.indexHandler),
],**settings)

if __name__ == "__main__":
    application.listen(9999)
    tornado.ioloop.IOLoop.instance().start()