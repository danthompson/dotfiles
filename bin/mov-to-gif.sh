#!/bin/bash

movie="$1"

[[ -f "$movie" ]] || {
  echo "Error: '$movie' not found" >&2
  exit 1
}

ffmpeg -i "${movie}" -pix_fmt rgb24 -vf "scale=-2:600" -r 10 -f gif "${movie}.gif"

# movie="$1"
# height=$(mdls -name kMDItemPixelHeight ${movie} | grep -o '[0-9]\+')
# width=$(mdls -name kMDItemPixelWidth ${movie} | grep -o '[0-9]\+')
#
# ffmpeg -i "${movie}" \
#        -s "${width}x${height} \
#        -pix_fmt rgb24 \
#        -r 10 \
#        -f gif \
#        "${movie}.gif"
