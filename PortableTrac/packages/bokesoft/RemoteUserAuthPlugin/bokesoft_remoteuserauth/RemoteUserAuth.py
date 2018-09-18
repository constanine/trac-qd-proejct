#!/usr/bin/env python
#-*- coding:utf-8 -*-

from trac.core import *
from trac.web.api import IAuthenticator

class BokesoftRemoteUserAuthenticator(Component):

    implements(IAuthenticator)

    def authenticate(self, req):
        if req.get_header('Remote-User'):
            return req.get_header('Remote-User')
        else:
            self.log.warn("%r: 找不到 HTTP Hader 'Remote-User', 不会执行单点登录动作.", req.path_info)
            return None
