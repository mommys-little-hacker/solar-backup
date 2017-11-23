#!/bin/bash
# Author: Maxim Vasilev <admin@qwertys.ru>
# Description: Logging function

logEvent() {
    timestamp=`date -R`
    log_msg="$@"

    echo "[$timestamp] $log_msg" >> $log_file
} 
