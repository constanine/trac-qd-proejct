# Install trac / apache in ubuntu 16.04
#  - 1.1 - 初始版本
#  - 2.0 - 修改为基于 basic-ubuntu-env 启动, 这样可以统一解决时区等问题
#
# Build this image:
#   docker build --force-rm -t boke-tracd:2.0 .
#   (可以使用代理服务器, 比如
#      docker build --force-rm -t boke-tracd:2.0 . --build-arg http_proxy="http://172.17.0.1:8123" --build-arg https_proxy="http://172.17.0.1:8123"
#   )
# Run this image:
#   docker run --rm -p 8080:8080 -v /tmp/trac-site:/data --name test-boke-tracd boke-tracd:2.0
# 创建临时容器, 直接进入终端(常用于排错):
#   docker run --rm -p 8080:8080 -v /tmp/trac-site:/data -it boke-tracd:2.0 bash
# 以终端方式 Attach 到正在运行的容器:
#   docker exec -it trac bash

FROM basic-ubuntu-env:1.0
MAINTAINER bokesoft.com

### 可调整的环境变量 #############################################################
# 参考 00-basic-ubuntu-env
# RT_WORK_COMMAND: 此命令不会被执行到(来自 00-basic-ubuntu-env)
ENV RT_WORK_COMMAND 'echo "Can not reach here !"'
###############################################################################

# Data volume for Trac
VOLUME ["/data"]

# tracd 的运行端口
EXPOSE 8080

# tracd 运行参数 BASE_PATH(--base-path=BASE_PATH) 和 basic 验证的 realm
ENV TRACD_BASE_PATH trac
ENV TRACD_REALM trac
#==================================================================================

# 安装必要的文件
RUN apt-get update
RUN apt-get install -y nano telnet vim

# Install dependencies
RUN apt-get install -y sqlite3
RUN apt-get install -y build-essential
RUN apt-get install -y python python-setuptools python-genshi python-subversion
RUN apt-get install -y python-dev libsqlite3-dev
RUN apt-get install -y subversion git

# Install graphviz, java, and Chinese font
RUN apt-get install -y graphviz
RUN apt-get install -y default-jre
RUN apt-get install -y ttf-wqy-microhei

# Install python-mysql
RUN apt-get install -y libmysqld-dev
RUN easy_install mysql-python
RUN easy_install pymysql

# Install htpasswd
RUN apt-get install -y apache2-utils

# Copy trac runtime
ADD ./PortableTrac /opt/trac
# Run install script
RUN /opt/trac/linux/install/install-PortableTrac.sh
RUN /opt/trac/packages/install-packages.sh

# 替换 root.sh (被 /docker-init/start.sh 调用)
ADD resources/docker-init/etc/root.sh /docker-init/etc/root.sh
