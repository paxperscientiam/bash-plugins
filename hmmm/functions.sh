function title {
    echo -ne "\\033]0;$*\\007";
}

function make_favicon {
    convert "${1:?}"  -background white \
            \( -clone 0 -resize 16x16 -extent 16x16 \) \
            \( -clone 0 -resize 32x32 -extent 32x32 \) \
            \( -clone 0 -resize 48x48 -extent 48x48 \) \
            \( -clone 0 -resize 64x64 -extent 64x64 \) \
            -delete 0 -alpha off -colors 256 favicon.ico
}

# ack a file
# ack '=>' --files-from=- < <(printf 'dist/code-2.7.0.js')
