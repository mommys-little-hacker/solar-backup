#!/bin/bash
# This function manages backup restoring

restoreBackup() {
    # Lock process or exit
    if [ -e $lockfile ]
    then
        logEvent "$MSG_LOCKED"
        exit $E_LOCKED
    else
        echo $my_pid > $lockfile
    fi

    echo $MSG_NOT_IMPLEMENTED && { rm $lockfile && exit $E_NOT_IMPLEMENTED ; }

    # Check if requested file is available
    #isAvailable || { rm $lockfile && exit $E_NOT_AVAILABLE }

    # Restore backup
    #restoreFiles || { rm $lockfile && exit $E_FILES_FAILED ; }
    #restoreDB || { rm $lockfile && exit $E_DB_FAILED ; }
    #restoreCron || { rm $lockfile && exit $E_CRON_FAILED ; }

    rm $lockfile
}
