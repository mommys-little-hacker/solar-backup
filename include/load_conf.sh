# This file loads application configuration

source $conf_file_default

if [[ ${conf_file-""} != "" && -r ${conf_file} ]]
then
    source $conf_file
else
    # Load global configuration and override it's values with user config
    source "$conf_file_global" || exit ${E_NOT_FOUND-20}
    if [ -r "$conf_file_user" ]; then source "$conf_file_user"; fi
fi 
