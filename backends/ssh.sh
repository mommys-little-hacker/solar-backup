#!/bin/bash
# This file provides SSH backend for uploading files
# Requires following vars: archive_name

ssh_cmd="ssh -q -o BatchMode=yes -p${ssh_port} ${ssh_user}@${ssh_host}"

# Common vars, must be present for every backend
stdin_conn="$ssh_cmd cat > ${ssh_basedir%%/}/${archive_name}"

uploadFile() {
    if [ $# -lt 1 ]
    then
        return 1
    fi

    file_path="$1"
    archive_name=`basename "$file_path"`

    $stdin_conn < "$file_path"
}

listDir() {
    $ssh_cmd ls "$ssh_basedir" || return 1
} 
