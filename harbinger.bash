#!/usr/bin/env bash
# https://developer.apple.com/library/content/documentation/AppleScript/Conceptual/AppleScriptLangGuide/reference/ASLR_cmds.html

function harbinger() {
    [[ ${#@} -eq 0 ]] && printf '%s\n' "harbinger <message>[,title][,subtitle]" && return 0

    local A
    IFS=',' read -r -a A <<< "${@}"

    local MSG="${A[0]}"
    local TITLE="${A[1]:+with title \"${A[1]}\"}"
    local SUBTITLE="${A[2]:+subtitle \"${A[2]}\"}"
    :
    local CMD

    CMD=$"display notification \"${MSG}\" ${TITLE} ${SUBTITLE}"

    #printf '%s\n' "${CMD}"
    osascript -e "${CMD}"

}

## per bpkg guidelines
if [[ ${BASH_SOURCE[0]} != "${0}" ]]; then
  export -f harbinger
else
  harbinger "${@}"
fi
