#!/bin/bash

function tc_wakey() {
    caffeinate -u -t 1
}

if [[ ${BASH_SOURCE[0]} != $0 ]]; then
    export -f tc_wakey
else
    tc_wakey "${@}"
    exit $?
fi
