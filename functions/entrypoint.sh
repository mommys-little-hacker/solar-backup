# This procedure parses args and calls other procs

entrypoint() {
    if [[ $# = 0 ]]
    then
        cat ${dir_app%%/}/data/badargs.txt
        exit $E_BAD_ARGS
    fi

    until [ -z $1 ]
    do
        case "$1" in
        --make|-m )
            makeBackup
            break ;;

        --list|-l )
            listBackups
            break ;;

        --rotate|-r )
            #rotateBackups
            break ;;

        --version|-V )
            cat ${app_dir%%/}/data/version.txt
            break ;;

        * )
            cat ${app_dir%%/}/data/badargs.txt
            exit $E_BAD_ARGS ;;
        esac

        shift
    done
}

