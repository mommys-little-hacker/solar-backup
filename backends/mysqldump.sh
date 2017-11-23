#!/bin/bash
# DB backup - MySQL backend

createDatabaseBackup() {
    if [ -r backends/${files_backend}.sh ]
    then :
    else
        logEvent "$MSG_NO_BACKEND"
        return 1
    fi

    db="$1"
    mysqldump_cmd="mysqldump --single-transaction -u${mysqldump_user}
    -p${mysqldump_pass} ${db-}"

    archive_name="mysql_${db}.${date_suffix}.sql.gz"
    source "backends/${files_backend}.sh"

    $mysqldump_cmd | $stdin_conn

    if [ ${PIPESTATUS[0]} -ne 0 ]
    then
        return 1
    fi
}
 
