#!/usr/bin/env bash

function f() {
    local D=$(convert ${1} -format "%[fx:w<h?w:h]" info:)

    convert -resize "${D}x${D}^" -extent "${D}x${D}" "${1}" result.jpg
}

f "${@}"
