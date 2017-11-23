#!/bin/bash
# This function lists contents of backup directory

listBackups() {
    exit_status=0

    if [ -r backends/"${files_backend-}".sh ]
    then
        source backends/${files_backend}.sh

        if [ -n "${hooks_pre_start-}" ]
        then
            runHook "$hooks_pre_start" || return 1
        fi

        listDir || exit_status=1

        if [ -n "${hooks_post_end-}" ]
        then
            runHook "$hooks_post_end" || return 1
        fi
    else
        logEvent "$MSG_NO_BACKEND"
        exit_status=1
    fi

    return $exit_status
}
