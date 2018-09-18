#! /bin/bash
set -o nounset
set -o errexit

# This is the restore shell script only for docker container "PortableTrac".
#   - https://github.com/thinkbase/Dockerfiles/tree/master/09-Apps/01-PortableTrac

export SITE_BASE=/data/trac

for DIR in `ls "${SITE_BASE}/backup/"`
do
    if [ -d "${SITE_BASE}/backup/${DIR}" ]
    then
        if [ "${DIR:0:1}" = "." ]
        then
            echo "Skip dicectory: ${DIR}"
        else
            set -x
            /home/u01/github/PortableTrac/bin/do_restore.sh $DIR
            set +x
        fi
    fi
done

set -x
chmod -Rv g+rw /data/trac/tracenv/*
set +x
