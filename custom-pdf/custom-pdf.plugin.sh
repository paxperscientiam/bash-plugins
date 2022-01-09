#!/usr/bin/env bash

if ! command -v gs >/dev/null 2>&1
then
    printf 'Unable to load custom-pdf plugin; ghostscript not found\n\n'
    return
fi

function pdfcrush {
    printf 'this function is broken\s'
    return
    local outFile="${2}"
    local inFile="${1}"

    [[ -z "${inFile}" ]] && printf 'Input pdf must be specified\n'; return

    [[ -z "${outFile}" ]] && outFile="${inFile}-compressed.pdf"


    gs -sDEVICE=pdfwrite \
       -dPDFSETTINGS=/screen \
       -dDetectDuplicateImages=true \
       -dCompatibilityLevel=1.4 \
       -dNOPAUSE \
       -dBATCH \
       -sOutputFile="${outFile}" "${inFile}"
    return $?
}

function pdfwatermark {
    if [[ "${1}" == '-h' ]]
then
    cat << EOF
Usage:
  watermarkpdf [-R] <filename> [watermark_text]

Options:
  -h   Show this screen
  -R   Replace original PDF file
EOF
    return
fi


if [[ "${1}" == '-R' ]]
then
    REPLACE=1
    shift 1
fi

filename="${1:?PDF path must be specified}"

if [[ ! -f "${filename}" ]]
then
    printf 'The file %s was not found!\n\n' "${filename}"
    return
fi

filenamebase="$(basename "${filename}" .pdf)"
dir="$(dirname "${filename}")"
watermark="${2:-DRAFT}"

outputfilename="${dir}/${filenamebase}_watermarked.pdf"
if [[ REPLACE -eq 1 ]]
then
    outputfilename="${filename}"
fi

cat << EOF >| "${TMPDIR}/watermark.ps"
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

}
