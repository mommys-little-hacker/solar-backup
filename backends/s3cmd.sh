#!/bin/bash
# This file provides backend for uploading files to a locally mounted FS
# Requires following vars: archive_name

# Common vars, must be present for every backend
stdin_conn="s3cmd -c $s3cmd_conf put - ${s3cmd_basedir%%/}/${archive_name-backup}"

uploadFile() {
    if [ $# -lt 1 ]
    then
        return 1
    fi

    file_path="$1"

    s3cmd -c "$s3cmd_conf" put "$file_path" $s3cmd_basedir/
}

listDir() {
    s3cmd -c "$s3cmd_conf" ls "${s3cmd_basedir}" || return 1
} 
