#! /bin/bash
set -x
set -o nounset
set -o errexit

TRAC_OWNER=$(stat -c %U /opt/trac)
if [ "${TRAC_OWNER}"x != "u01"x ]; then
	echo ">>> Chown of /opt/trac from ${TRAC_OWNER} to u01 ..."
    chown -R u01:u01 /opt/trac
fi

export SITE_BASE=/data

if [ ! -d "$SITE_BASE/tracenv" ]
then
	# 如果指定的数据目录是空目录, 则做基本的初始化, 包括创建 admin 用户(使用默认密码 "111111")以及创建一个 "default" 的 trac env
	mkdir -p "$SITE_BASE/protected"
	mkdir -p "$SITE_BASE/tracenv"
    # restore the default tracenv
    cp -rv "/opt/trac/backup/default" "$SITE_BASE/tracenv/"
    sqlite3 "$SITE_BASE/tracenv/default/db/trac.db" < "$SITE_BASE/tracenv/default/trac-db.sql"
	# Init password
    htpasswd -bc "$SITE_BASE/protected/passwd" admin 111111
    # finally
    chown -Rv u01:u01 "$SITE_BASE"
fi

# 准备默认的 `PYTHON_EGG_CACHE` 目录
mkdir -p /home/u01/.python-eggs
chown -Rv u01:u01 /home/u01/.python-eggs

# 以用户 'u01' 启动 tracd
su u01 -c "export SITE_BASE=/data ; /opt/trac/tracd.sh 8080"
