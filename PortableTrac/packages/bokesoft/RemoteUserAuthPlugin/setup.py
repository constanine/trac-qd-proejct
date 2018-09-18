#!/usr/bin/env python
#-*- coding:utf-8 -*-

#通过获取 HTTP Header 'Remote-User' 实现 Trac 的自动登录, 通常用于在 Apache httpd 反向代理后面等场景下。
#参考： https://trac.edgewall.org/wiki/TracStandalone#Authenticationfortracdbehindaproxy

from setuptools import setup, find_packages

setup(
    name = "bokesoft_remoteuserauth",
    version="0.1.0",
    #packages=find_packages(),
    packages = ['bokesoft_remoteuserauth'],
    package_data = {'bokesoft_remoteuserauth' : ['templates/*.html', 'htdocs/*.png', 'htdocs/css/*.css']},
    zip_safe = False,

    description = "通过 'Remote-User' HTTP Header 实现单点登录.",
    long_description = "Single-Sign-On with 'Remote-User:' HTTP header.",
    author = "bokesoft",

    license = "GPL",
    keywords = ("bokesoft", "auth", "remote-user"),
    platforms = "Independant",
    url = "https://dev.bokesoft.com/svn/Yigo-redist/trunk/Deployment/infrastructure/Dockerfiles/41-PortableTrac/PortableTrac/packages/bokesoft/RemoteUserAuthPlugin",
    entry_points = {
        'trac.plugins': [
            'bokesoft_remoteuserauth = bokesoft_remoteuserauth.RemoteUserAuth'
        ]
    }

)
