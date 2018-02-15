#!/bin/bash
# This function implements emergency exit
errorExit() {
    error_code=${1-$E_MISC}
    error_msg=${2-"$MSG_MISC_FAIL"}

    logEvent "$error_msg"

    if [[ -w $lockfile ]]
    then
        rm -f $lockfile
    fi

    exit $error_code
}
