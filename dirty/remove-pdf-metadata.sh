#!/bin/bash

FILE=example.pdf

# read tags from the original PDF
#exiftool -all:all $FILE

# remove tags (XMP + metadata) from the PDF
exiftool -all:all= $FILE

# linearize the file to remove orphan data
qpdf --linearize $FILE

# read XMP from the modified PDF
#exiftool -all:all $FILE

# read all strings from the modified PDF
#cat $FILE | strings > $FILE.txt

# read XMP from embedded objects in the modified PDF
#exiftool -extractEmbedded -all:all $FILE
