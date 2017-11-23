#!/bin/bash
# Author: Maxim Vasilev <admin@qwertys.ru>
# Description: Creates backup of a project. Main executable.

# Raise an error in case of unbound var
set -u -o pipefail

###
# Environment setup
###

my_dir="/opt/solar-backup/"
my_pid=$$

cd $my_dir

# Load application global vars, consts and functions
for conf_dir in data functions
do
    for conf_file in "$conf_dir"/*.sh
    do
        source "$conf_file" || exit ${E_NOT_FOUND-20}
    done
done

# Load global configuration
source "$conf_file_global" || exit ${E_NOT_FOUND-20}

# Load per user conf
if [ -r "$conf_file_user" ]
then
    source "$conf_file_user"
fi

###
# This funtion checks args and starts requested action.
###

entrypoint $@

exit 0 
