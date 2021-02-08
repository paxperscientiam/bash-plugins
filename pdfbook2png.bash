#!/usr/bin/env bash

function doIt() {
    local PDF="${1:?}"
    local prefix="${2}"

    [[ ! -f "${PDF}" ]] && printf 'The file %s does not exist!\n' "${PDF}"

    pdftoppm -scale-to 900 -f 1 -png -r 150 "${PDF}" "${prefix:=r}"
}

doIt "${@}"
