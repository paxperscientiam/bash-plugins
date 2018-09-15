#!/usr/bin/env bash


function imgcrush() {
    command -v pngcrush >/dev/null 2>&1 || \
        { printf '%s\n' "Pngcrush not found!" && return 1; }

    for png in $(find . -name "*.png");
    do
	      echo "crushing $png"
	      pngcrush -brute "${png}" temp.png
	      mv -f temp.png "${png}"
    done;
}

## per bpkg guidelines
if [[ ${BASH_SOURCE[0]} != "${0}" ]]; then
    export -f imgcrush
else
    imgcrush "${@}"
fi
