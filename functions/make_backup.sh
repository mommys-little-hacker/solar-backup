#!/bin/bash
# This function outlines backup creation

makeBackup() {
    # Lock process or exit
    if [ -e $lockfile ]
    then
        logEvent "$MSG_LOCKED"
        exit $E_LOCKED
    else
        echo $my_pid > $lockfile
    fi

    # Redirect output if needed
    if [ "$log_applications" = "true" ]
    then
        exec >> "$log_file"
        exec 2>> "$log_file"
    fi

    runHook "${hooks_pre_start-}" || { rm $lockfile && return 1 ; }

    backupFiles || { rm $lockfile && exit $E_FILES_FAILED ; }
    backupDB || { rm $lockfile && exit $E_DB_FAILED ; }
    backupCron || { rm $lockfile && exit $E_CRON_FAILED ; }

    runHook "${hooks_post_end-}" || { rm $lockfile && return 1 ; }

    rm $lockfile
}
