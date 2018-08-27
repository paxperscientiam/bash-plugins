#!/usr/bin/env bash

function whereami() (
    /usr/bin/curl --disable ipinfo.io/region
)

if [[ ${BASH_SOURCE[0]} != $0 ]]; then
    export -f whereami
else
    whereami "${@}"
    exit $?
fi
