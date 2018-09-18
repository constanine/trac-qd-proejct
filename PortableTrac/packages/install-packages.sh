#! /bin/bash

set -o nounset
set -o errexit

set -x

function do_install(){
    local PKGS_ROOT="/opt/trac/packages"
    local path="$1"

    rm -rfv "${PKGS_ROOT}/$1/*.egg-info/"
    rm -rfv "${PKGS_ROOT}/$1/build/"
    rm -rfv "${PKGS_ROOT}/$1/dist/"

    cd "${PKGS_ROOT}/$1"
    python setup.py install
}

do_install "trac-hacks/tagsplugin"
do_install "trac-hacks/fullblogplugin"

do_install "bokesoft/RemoteUserAuthPlugin"
