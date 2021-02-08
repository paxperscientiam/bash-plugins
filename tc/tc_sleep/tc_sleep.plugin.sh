#!/bin/bash

function tc_sleep() {
    pmset displaysleepnow
}


if [[ ${BASH_SOURCE[0]} != $0 ]]; then
    export -f tc_sleep
else
    tc_sleep "${@}"
    exit $?
fi
