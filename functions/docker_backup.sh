#!/bin/bash
# Docker backend

backupDocker() {
    if [[ "$backup_docker" != "true" ]] 
    then
        logEvent "$MSG_DOCKER_SKIP"
        return 0
    fi

    runHook "${hooks_pre_docker-}" || return 1

    logEvent "$MSG_DOCKER_START"

    for container in ${docker_cnts[@]}
    do
        tag="$date_suffix"
        img="${container}:${tag}"
        archive_name="docker_$container.$date_suffix.tar"

        if [[ ! -r ${app_dir%%/}/backends/${files_backend}.sh ]]
        then
            logEvent "$MSG_NO_BACKEND"
            return 1
        fi

        source "${app_dir%%/}/backends/${files_backend}.sh"
        docker commit --pause=false $container ${container}:${tag} || { logEvent "$MSG_DOCKER_WARN"; continue ; }
        docker save $img | $stdin_conn

        pipestat="${PIPESTATUS[@]}"
        if [[ ${pipestat[0]} != 0 ]]
        then
            logEvent "$MSG_DOCKER_WARN"
        fi
    done

    logEvent "$MSG_DOCKER_FINISH"

    runHook "${hooks_post_docker-}" || return 1
}
