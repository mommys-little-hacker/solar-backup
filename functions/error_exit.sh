#!/bin/bash
# This function implements emergency exit
errorExit() {
    error_code=$1

    if [[ -f $lockfile ]]
    then
        rm -f $lockfile
    fi

    exit $error_code
}
