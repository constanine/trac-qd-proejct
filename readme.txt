用于配合 Docker 实现 trac/svn 站点。

宿主机环境准备
============
 * 检出基本目录结构
  - 检出后目录应该在 ~/site/applications/trac-svn-yigo-support 下

 * 准备相关脚本支持等内容
  - git clone https://github.com/thinkbase/AdminShells ~/site/applications/trac-svn-yigoresearch/misc/AdminShells

启动及初始化
============
 * 将 trac 数据恢复到 trac/backup, 将必要的 SVN 数据恢复到 trac/svn-sync-repo/repo
 
 * 通过 docker-compose up -d && docker-compose logs -f 启动
 
 * 恢复 trac 环境
  - 通过 docker exec -it trac-svn-yigoresearch_trac-and-svn_1 bash 进入容器
  - 在容器中以 u01 身份执行 restore:
		su - u01
		cd /data/trac
		./restore.sh

 * 注意设置 SVN 同步的参数：
  - site/applications/trac-svn-yigoresearch/trac/svn-sync-repo/conf.d/.passwd.rc

其他
============
 * 开启 eth0 的 2003 端口访问
  - sudo ufw allow in on eth0 to any port 2003

END
