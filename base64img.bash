#!/usr/bin/env bash


function base64img() {
    local ext
    local raw

    ext="${1##*.}"

    raw=$(openssl base64 -A -in "${1}")

    printf 'data:image/%s;base64,%s' "${ext}" "${raw}" | pbcopy &
    wait
    printf '%s\n' "Content in clipboad."

}
