runHook () {
    hook=$1
    hook_path="${hooks_dir%%/}/${hook}"

    if [[ "$hook" = "" ]]; then return 0; fi

    if [[ "$hooks_enable" = "true" && -x "$hook_path" ]]
    then
        logEvent "$MSG_HOOKS_START $hook"
        "$hook_path" || { logEvent "$MSG_HOOKS_FAIL $hook" && return 1 ; }
    fi
} 
