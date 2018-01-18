#!/bin/bash
# Author: Maxim Vasilev <admin@qwertys.ru>
# Description: Creates backup of a project. Main executable.
# This specific file loads application and calls exrypoint
# function.

# Raise an error in case of:
# * unbound var
# * any command in pipeline
set -u -o pipefail

###
# Load application
###

app_dir=${INSTALLDIR-"/opt/solar-backup"}
override_file=${CONFFILE-""}

# Load application global vars, consts and functions
for conf_dir in data functions
do
    for conf_file in "${app_dir%%/}/${conf_dir}"/*.sh
    do
        source "$conf_file" || exit ${E_NOT_FOUND-20}
    done
done

###
# This funtion checks args and starts requested action.
###

entrypoint $@

exit 0 
