#!/usr/bin/env bash

function tc_listen() {
    [[ "${1}" == '-h' ]] && \
        printf '%s\n' "default: rec -c 2 listen_TIMESTAMP.ogg trim 0 10:00" && return 0
    local cmd
    local savedir
    local format
    local trim
    local date
    date=$(date +%FT%T%Z)

    while [[ "${#1}" -gt 0 ]]; do
        case "${1}" in
            -s|--savedir)
                savedir="${2:-'./'}/tc_listen"
                ;;
            -f|--format)
                format="${2}"
                ;;
            -t|--trim)
                trim="${2}"
                ;;
        esac
        shift 1
    done

    # override
    savedir="${HOME}"'/Google Drive/tc_listen'

    [[ -d "${TMPDIR:?}/tc_listen" ]] || mkdir "${TMPDIR:?}/tc_listen"

    savedir_default="${TMPDIR:?}/tc_listen/"

    savedir="${savedir:-${savedir_default}}"

    [[ -d "${savedir}" ]] || mkdir -p "${savedir}"

    format="${format:-ogg}"
    trim="${trim:-10:00}"

    cmd=$'command rec -c 2 \"${savedir:?}/listen_${date}.${format/\./}\" trim 0 ${trim}'
    printf 'command: %s\n' "${cmd}"

    command -v sox >/dev/null 2>&1 || { echo >&2 "I require sox but it's not installed.  Aborting."; return 1; }
    eval "${cmd}"
}


if [[ ${BASH_SOURCE[0]} != $0 ]]; then
    export -f tc_listen
else
    tc_listen "${@}"
    exit $?
fi
