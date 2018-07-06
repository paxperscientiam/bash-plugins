#!/usr/bin/env bash

tag="tunnel"
CT_INTERFACE="wifi"
CT_RELAY_SERVER="pax"

shopt -s expand_aliases



_enviroTest() {
    case "${OSTYPE}" in
        darwin*)
        ;;
        linux*)
        ;;
    esac

    if command nc -V >/dev/null 2>&1
    then
        printf '%s\n' "GNU version of netcat"
        alias NC='nc -w 5 '
    elif [[ "${?}" -ne 127 ]]
    then
        alias NC='nc -G 5 '
    else
        >&2 printf '%s\n' "netcat is required."
        return 1
    fi
}

# while true
# do
#     case $1 in
#         -r)
#             CT_RELAY_SERVER="${2}"
#             [[ ${#CT_INTERFACE} -gt 0 ]] && break
#             shift 2
#             ;;
#         -i)
#             CT_INTERFACE="${2}"
#             [[ ${#CT_RELAY_SERVER} -gt 0 ]] && break
#             shift 2
#             ;;
#     esac
# done

# #ssh -L 10001:one.securedomain.com:3389 -L 10002:two.securedomain.com:3389 steve@tunnel.trusteddomain.com


_mngWifi() {

    :

}


_testSSH() {
    local REMOTE
    local code
    REMOTE="${1}"
    :
    /usr/bin/ssh -vvv -4 -q "${REMOTE}" exit
    code="${?}"

    if [[ "${code}" -ne 0 ]];
    then
        >&2 printf 'Failed to connect to remote %s\n' "${REMOTE}"
    fi
    return "${?}"
}

_testDNS() {
    if NC -zn 8.8.8.8 53 > /dev/null
    then
         printf 'Successfully connected to DNS server 8.8.8.8.\n'
        return 0
    elif NC -zn 1.1.1.1 53 > /dev/null
    then
        printf 'Successfully connected to DNS server 1.1.1.1.\n'
        return 0
    fi
    >&2 printf 'Failed to reach a DNS server.\n'
    return 1
}


_tunnel() {
    local REMOTE
    REMOTE="${1}"
    # -Y for x11 not working, -T disable pseudo tty
    if /usr/bin/ssh -v -4 -f -T -N -R10022:localhost:22 -L19922:"${REMOTE}":22 "${REMOTE}"
    then
        printf '%s: Tunnel to relay server created successfully!\n' "${tag}"
    else
        printf '%s:  An error occurred creating a tunnel to relay server. Return code: %s\n' "${tag}" "$?"
        return 1
    fi
    return 0
}

createTunnel() {
    local code
    :
    _testDNS &
    wait
    code="${?}"
    echo "DNS CODE IS ${code}"

    [[ "${code}" -ne 0 ]] && return "${code}"


    _testSSH "${CT_RELAY_SERVER}" &
    wait
    code="${?}"
    echo "SSH CODE IS ${code}"

    [[ "${code}" -ne 0 ]] && return "${code}"


    if ! /usr/bin/nc -zn4 127.0.0.1 19922 > /dev/null 1>&2
    then
        printf '%s: Creating new tunnel connection to relay server.\n' "${tag}" 1>&2
        _tunnel "${CT_RELAY_SERVER}"
    fi
}



if [[ ${BASH_SOURCE[0]} != $0 ]]; then
    export -f createTunnel
else
    createTunnel "${@}"
    exit $?
fi
