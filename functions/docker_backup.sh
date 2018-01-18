#!/bin/bash
# Docker backend

backupDocker() {
    if [[ "$backup_docker" != "true" ]] 
    then
        logEvent "$MSG_DOCKER_SKIP"
        return 0
    fi

    runHook "${hooks_pre_docker-}" || return 1

    echo

    runHook "${hooks_post_docker-}" || return 1
}

