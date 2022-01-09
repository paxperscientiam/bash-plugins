#!/usr/bin/env bash
#### Created by Jean-Pierre Fourie
### https://github.com/emotality
## set_permissions.sh
#

function fix_perms () {
    var=$(pwd)
    echo " The current working directory is: '$var'"

    #    read -r -p " Set all Folders permission to [eg. 0751]: " permissions
    find . -type d -print0 | xargs -0 chmod 0751

    #   read -r -p " Set all Files permission to [eg. 0644]: " permissions
    find . -type f -print0 | xargs -0 chmod 0644

    printf " Folders and files permissions set! Exiting.\\n"
}

function whereami() (
    /usr/bin/curl --disable ipinfo.io/region
)
