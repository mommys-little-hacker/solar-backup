# This procedure parses args and calls other procs

entrypoint() {
    if [[ $# = 0 ]]
    then
        cat data/badargs.txt
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

        --restore|-R )
            if [[ $# < 2 ]]
            then
                cat data/badargs.txt
                exit $E_BAD_ARGS
            else
                subject="$2"
                restoreBackup "$subject"
            fi ;;

        --version|-V )
            cat data/version.txt
	    break ;;

        * )
            cat data/badargs.txt
            exit $E_BAD_ARGS ;;
        esac

        shift
    done
}

