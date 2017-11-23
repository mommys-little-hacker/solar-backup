#!/bin/bash
# Function for site backup

backupFiles() {
    if [ "$backup_files" != "true" ] 
    then
        logEvent "$MSG_FILES_SKIP"
        return 0
    fi

    if [ -r backends/${files_backend}.sh ]
    then :
    else
        logEvent "$MSG_NO_BACKEND"
        return 1
    fi

    if [ -n "${hooks_pre_files-}" ]
    then
        runHook "$hooks_pre_files" || return 1
    fi

    logEvent "$MSG_FILES_START"

    for dir in ${files_dirs[@]}
    do
        archive_name="${dir//'/'/_}.${date_suffix}.tar.gz"
        source "backends/${files_backend}.sh"

        tar -cz "$dir" 2> /dev/null | $stdin_conn || return 1
        if [ ${PIPESTATUS[0]} -ne 0 ]
            then
            return 1
        fi
    done

    logEvent "$MSG_FILES_FINISH"

    if [ -n "${hooks_post_files-}" ]
    then
        runHook "$hooks_post_files" || return 1
    fi
}
