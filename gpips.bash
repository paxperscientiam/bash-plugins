#!/usr/bin/env bash

# While I use macports to install pretty much all my python stuff, I still have a separate library of stuff not available on macports. Either way, I let macports handle package dependencies.

# Note: only tested on macOS; asssumes appropriate pips installed
# Disclaimer: use at your own peril
# Parting words: have a nice day

shopt -s expand_aliases

export PIP_DISABLE_PIP_VERSION_CHECK=1
# edit this accordingly
pyverz=(
    "2.7"
    "3.4"
    "3.6"
)

for py in "${pyverz[@]}"
do
    if command -v "python${py}" > /dev/null 2>&1
    then
        pyvar="python${py} -m pip"
        opts="--cache-dir=${HOME}/.pip/$py/cache --disable-pip-version-check --user --no-deps"
        alias py="${pyvar}"

        source <(cat << EOF
function gpip${py//./} ()
{
        if [[ "\$*" =~ ("list"|"list \-o"|"list --outdated") ]]
        then
            py "\${@}" --format=columns --user --no-cache-dir
        elif [[ "\$*" =~ "uninstall" ]]
        then
            ${pyvar} "\$@"
        elif [[ "\$*" =~ uninstall-all|ua ]]
        then
          echo "Uninstalling all user packages."
            py freeze --user | grep -v '^\\-e' | cut -d = -f 1 | xargs -n1 ${pyvar} uninstall
        elif [[ "\$*" =~ (install|"-r") ]]
        then
            ${pyvar} "\$@" ${opts}
        elif [[ "\$*" =~ "upgrade" ]]
        then
            py freeze --user | grep -v '^\\-e' | cut -d = -f 1 | xargs -n1 ${pyvar} install -U --user
        elif [[ "\$*" =~ config|check|search ]]
        then
           py "\${@}"
        else
            echo "Unsupported option."
        fi
}
EOF
                )
    fi
done
