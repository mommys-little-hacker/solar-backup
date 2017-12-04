#!/bin/bash
# This function manages crontab backup

backupCron() {
    if [ "$backup_cron" != "true" ] 
    then
        logEvent "$MSG_CRON_SKIP"
        return 0
    fi

    runHook "${hooks_pre_cron-}" || return 1

    logEvent "$MSG_CRON_START"

    # Create temporary directory if it does not exist yet
    if [ ! -d "$cron_tmp_dir" ]
    then
        mkdir -p "$cron_tmp_dir"
    fi

    # Back crontab up per user into this directory
    for user in ${cron_users[@]}
    do
        crontab -u "$user" -l > "${cron_tmp_dir}/${user}"
    done

    # Create archive and upload it to storage
    if [ -n "$files_backend" ]
    then
        archive_name="cron.${date_suffix}.tar.gz"
        source "${app_dir%%/}/backends/${files_backend}.sh" || return 1

        tar -cz "${cron_tmp_dir}" > "/tmp/${archive_name}" 2> /dev/null
        uploadFile "/tmp/${archive_name}" || return 1

        rm /tmp/$archive_name
        rm -rf ${cron_tmp_dir}
    else
        logEvent "$MSG_NO_BACKEND"
        return 1
    fi

    logEvent "$MSG_CRON_FINISH"

    runHook "${hooks_post_cron-}" || return 1
}
 
