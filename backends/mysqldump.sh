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
    mysqldump_opts="--single-transaction --skip-lock-tables"

    if [[ $db = "ALL" ]]
    then
        mysqldump_db=""
        mysqldump_opts="--single-transaction --skip-lock-tables -A"
    else
        mysqldump_db="$db"
        mysqldump_opts="--single-transaction --skip-lock-tables"
    fi

    if [[ ${mysqldump_user-""} != "" ]]; then _mysqldump_user="${mysqldump_user/#/'-u'}"; fi
    if [[ ${mysqldump_pass-""} != "" ]]; then _mysqldump_pass="${mysqldump_pass/#/'-p'}"; fi
    if [[ ${mysqldump_host-""} != "" ]]; then _mysqldump_host="${mysqldump_host/#/'-h'}"; fi

    mysqldump_cmd="mysqldump $mysqldump_opts
        ${_mysqldump_user-} ${_mysqldump_pass-} ${_mysqldump_host-} ${mysqldump_db-}"

    archive_name="mysql_${db}.${date_suffix}.sql.gz"
    source "backends/${files_backend}.sh"

    $mysqldump_cmd | $stdin_conn

    if [ ${PIPESTATUS[0]} -ne 0 ]
    then
        return 1
    fi
}
 
