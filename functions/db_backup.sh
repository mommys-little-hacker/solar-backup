#!/bin/bash
# This function manages database backup

backupDB() {
    if [[ "$backup_db" != "true" ]]
    then
        logEvent "$MSG_DB_SKIP"
        return 0
    fi

    runHook "${hooks_pre_db-}" || return 1

    logEvent "$MSG_DB_START"

    if [[ -n "{$db_backend-}" ]]
    then
        for db in ${db_dbs[@]}
        do
            source "${app_dir%%/}/backends/${db_backend}.sh" || return 1
            createDatabaseBackup "$db" || return 1
        done
    else
        logEvent "$MSG_NO_BACKEND"
        return 1
    fi

    logEvent "$MSG_DB_FINISH"

    runHook "${hooks_post_db-}" || return 1
}
 
