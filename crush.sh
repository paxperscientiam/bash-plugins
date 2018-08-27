#!/bin/sh
for png in *.png;
do
	echo "crushing $png"
	pngcrush "$png" temp.png
	mv -f temp.png "$png"
done;
