#!/bin/bash
# This function outlines backup creation

makeBackup() {
    # Load configuration file
    source ${app_dir%%/}/include/load_conf.sh || exit $E_MISC

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

    backupFiles || errorExit $E_FILES_FAILED "$MSG_FILES_FAIL"
    backupDB || errorExit $E_DB_FAILED "$MSG_DB_FAIL"
    backupCron || errorExit $E_CRON_FAILED "$MSG_CRON_FAIL"

    runHook "${hooks_post_end-}" || { rm $lockfile && return 1 ; }

    rm $lockfile
}
