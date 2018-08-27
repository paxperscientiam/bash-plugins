#!/usr/bin/env bash

function crush() {
for png in *.png;
do
	echo "crushing $png"
	pngcrush "$png" temp.png
	mv -f temp.png "$png"
done;
}

if [[ ${BASH_SOURCE[0]} != $0 ]]; then
    export -f crush
else
    crush "${@}"
    exit $?
fi
