#! /bin/bash
set -o nounset
set -o errexit
set -x
# This is the backup shell script only for docker container "PortableTrac".
#   - https://github.com/thinkbase/Dockerfiles/tree/master/09-Apps/01-PortableTrac

export PATH=/usr/local/bin:$PATH

export SITE_BASE=/data/trac

for DIR in `ls "${SITE_BASE}/tracenv/"`
do
    if [ -d "${SITE_BASE}/tracenv/${DIR}" ]
    then
        if [ "${DIR:0:1}" = "." ]
        then
            echo "Skip dicectory: ${DIR}"
        else
            set -x
            /home/u01/github/PortableTrac/trac-backup.sh $DIR
            set +x
        fi
    fi
done

