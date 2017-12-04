#!/bin/bash
# This function lists contents of backup directory

listBackups() {
    exit_status=0

    if [[ -r ${app_dir%%/}/backends/"${files_backend-}".sh ]]
    then
        runHook "${hooks_pre_start-}" || return 1

        source ${app_dir%%/}backends/${files_backend}.sh
        listDir || exit_status=1

        runHook "${hooks_post_end-}" || return 1
    else
        logEvent "$MSG_NO_BACKEND"
        exit_status=1
    fi

    return $exit_status
}
