#! /bin/bash
set -o nounset
set -o errexit
set -x

export LC_CTYPE=en_US.UTF-8
export PATH=/usr/local/bin:$PATH

export SVN_SYNC_BASE=/data/trac/svn-sync-repo
/data/misc/AdminShells/svnsync/svn-sync.sh

export SITE_BASE=/data/trac
/home/u01/github/PortableTrac/repo-sync.sh

