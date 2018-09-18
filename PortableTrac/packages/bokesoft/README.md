关于创建 egg 形式的 Trac Plugin
========

参考
--------
https://trac.edgewall.org/wiki/TracDev/PluginDevelopment

开发：与 Docker 镜像配合使用
--------
基本的开发和测试可以基于目前 Docker 镜像完成。

以 `RemoteUserAuthPlugin` 为例：
 1. 首先通过将本地 `PortableTrac` 目录映射到 `/home/u01/trac` 的方式启动 Docker 容器, 进入 bash：
    ```shell
    docker run -p 8080:8080 -v /tmp/trac-site:/data -v $(pwd)/PortableTrac:/home/u01/trac -it --rm boke-tracd:1.1 bash
    ```

 2. 然后在容器中，进入相应的目录，打包安装，启动 tracd:
    ```shell
    # 进入插件模块所在的目录
    cd /home/u01/trac/packages/bokesoft/RemoteUserAuthPlugin
    # egg 包打包并安装
    python setup.py install
    # 清除当前目录打包的结果(可选)
    rm -rfv *.egg-info/ build/ dist/
    # 启动 tracd
    /home/u01/start.sh
    ```

END
--------
