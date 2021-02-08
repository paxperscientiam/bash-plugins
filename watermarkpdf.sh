#!/usr/bin/env bash
# Add a watermark to a PDF file
#
# first argument: the filename
# second argument: the watermark text (default "watermark")

if [[ "${1}" == '-h' ]]
then
    cat << EOF
Usage:
  watermarkpdf [-R] <filename> [watermark_text]

Options:
  -h   Show this screen
  -R   Replace original PDF file
EOF
    exit
fi


if [[ "${1}" == '-R' ]]
then
    REPLACE=1
    shift 1
fi

filename="${1:?PDF path must be specified}"

if [[ ! -f "${filename}" ]]
then
    printf 'The file %s was not found!' "${filename}"
    exit
fi

filenamebase="$(basename "${filename}" .pdf)"
watermark="${2:-DRAFT}"

outputfilename="${filenamebase}_${watermark}.pdf"
if [[ REPLACE -eq 1 ]]
then
    outputfilename="${filename}"
fi

cat << EOF > "${TMPDIR}/watermark.ps"
<<
   /EndPage
   {
     2 eq { pop false }
     {
         gsave
         0.5 .setopacityalpha
         /Helvetica 120 selectfont
         .65 setgray 130 70 moveto 50 rotate ($watermark) show
         grestore
         true
     } ifelse
   } bind
>> setpagedevice
EOF

gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile="${outputfilename}" "${TMPDIR}/watermark.ps" "${filename}" && \
    [[ REPLACE -eq 1 ]] && mv "${outputfilename}" "${filename}"
