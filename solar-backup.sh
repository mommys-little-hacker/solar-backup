#!/bin/bash
# Author: Maxim Vasilev <admin@qwertys.ru>
# Description: Creates backup of a project. Main executable.
# This specific file loads configuration

# Raise an error in case of unbound var
set -u -o pipefail

###
# Environment setup
###

my_dir=`dirname $0`

# Load application global vars, consts and functions
for conf_dir in data functions
do
    for conf_file in "${my_dir%%/}/${conf_dir}"/*.sh
    do
        source "$conf_file" || exit ${E_NOT_FOUND-20}
    done
done

if [[ ${CONFFILE-""} != "" && -r ${CONFFILE} ]]
then
    source $CONFFILE
else
    # Load global configuration and override it's values with user config
    source "$conf_file_global" || exit ${E_NOT_FOUND-20}
    if [ -r "$conf_file_user" ]; then source "$conf_file_user"; fi
fi

###
# This funtion checks args and starts requested action.
###

entrypoint $@

exit 0 
