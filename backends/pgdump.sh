#!/bin/bash
# DB backup - pg_dump backend

createDatabaseBackup() {
    if [[ ! -r ${app_dir%%/}/backends/${files_backend}.sh ]]
    then
        logEvent "$MSG_NO_BACKEND"
        return 1
    fi

    db="$1"

    if [[ $db = "ALL" ]]
    then
        pgdump_db=""
        pgdump_exe="pg_dumpall"
    else
        pgdump_db="${db/#/'-d '}"
        pgdump_exe="pg_dump"
    fi

    if [[ ${pgdump_user-""} != "" ]]; then _pgdump_user="${pgdump_user/#/'-U '}"; fi
    if [[ ${pgdump_host-""} != "" ]]; then _pgdump_host="${pgdump_host/#/'-h '}"; fi

    pgdump_cmd="PGPASSWORD=${pgdump_pass-} $pgdump_exe
        ${_pgdump_user-} ${_pgdump_host-} ${pgdump_db-}"

    archive_name="pg_${db}.${date_suffix}.sql.gz"
    source "${app_dir%%/}/backends/${files_backend}.sh"

    $pgdump_cmd | $stdin_conn

    if [ ${PIPESTATUS[0]} -ne 0 ]
    then
        return 1
    fi
}
 
 
