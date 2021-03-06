#! /bin/bash
set -o nounset
set -o errexit

source $(cd "$(dirname "$0")"; pwd)/init-env.sh

set +o nounset
ENV="$1"
if [ -z $ENV ]
then
    echo -e "\nError: 1st argument[trac environment] missing.\n"
    exit -10
fi
set -o nounset

COPY_SOURCE=$TRACENV/../backup/$ENV
if [ ! -d "$COPY_SOURCE" ]
then
    echo -e "\nbackup folder [$COPY_SOURCE] not found.\n"
    exit -20
else
    if [ -d "$TRACENV/$ENV" ]
    then
        echo -e "\nError: trac environment [$TRACENV/$ENV] already exists.\n"
        exit -21
    fi
fi

# Restore trac-env from backup
set -x
cp -rv "$COPY_SOURCE" "$TRACENV/$ENV/"
rm -fv "$TRACENV/$ENV/db/trac.db"
sqlite3 "$TRACENV/$ENV/db/trac.db" < "$TRACENV/$ENV/trac-db.sql"
set +x
