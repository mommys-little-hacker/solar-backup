#!/bin/bash
# This file provides ftp backend for uploading files
# Requires following vars: archive_name

# Backend-specific vars
file_path="misc.tar.gz"
ftp_baseurl="ftp://${ftp_user}:${ftp_pass}@${ftp_host}${ftp_basedir}"
ftp_conn="curl -s -T $file_path $ftp_baseurl"

# Common vars, must be present for every backend
stdin_conn="curl -s -T . ${ftp_baseurl%%/}/${archive_name}"

uploadFile() {
    if [ $# -lt 1 ]
    then
        return 1
    fi

    file_path="$1"
    file_name=`basename "$file_path"`
    ftp_conn="curl -s -T $file_path ${ftp_baseurl%%/}/${file_name}"

    $ftp_conn || return 1
}

listDir() {
    ftp_list="curl -sl ${ftp_baseurl%%/}/"

    $ftp_list | grep -vE '^\.+$'

    if [ ${PIPESTATUS[0]} -ne 0 ]
    then
        return 1
    fi
}
 
