#!/bin/bash
# This file provides backend for uploading files to a locally mounted FS
# Requires following vars: archive_name

# Common vars, must be present for every backend
if [[ "${split_enabled-false}" = "true" ]]
then
    split -b${split_chunk_size-4G} - ${archive_name-backup} --filter='eval cat > ${local_basedir%%/}/$FILE'
else
    stdin_conn="eval cat > ${local_basedir%%/}/${archive_name-backup}"
fi

uploadFile() {
    if [ $# -lt 1 ]
    then
        return 1
    fi

    file_path="$1"

    cp -f "$file_path" $local_basedir
}

listDir() {
    ls ${local_basedir} || return 1
} 
 
