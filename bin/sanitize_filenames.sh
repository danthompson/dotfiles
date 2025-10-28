#!/bin/bash

usage() {
  cat <<EOF
Usage: $(basename "$0") [-d] [-n] [file ...]

Sanitize filenames by replacing non-alphanumeric characters with underscores.

Options:
  -d    Sanitize all files in the current directory
  -n    Dry run (show renames without performing them)
  -h    Show this help message

Arguments:
  file  One or more files to sanitize
EOF
  exit "${1:-0}"
}

sanitize_file() {
  local file="$1"

  [ -f "$file" ] || {
    echo "Skipping: '$file' (not a regular file)" >&2
    return 1
  }

  local dir filename extension sanitized sanitized_file
  dir="$(dirname "$file")"
  filename="$(basename "${file%.*}")"
  extension="${file##*.}"

  sanitized=$(echo "$filename" | sed -E 's/[^a-zA-Z0-9]+/_/g')
  sanitized_file="${dir}/${sanitized}.${extension}"

  if [ "$file" != "$sanitized_file" ]; then
    if $dry_run; then
      echo "Would rename: '$file' to '$sanitized_file'"
    else
      mv "$file" "$sanitized_file"
      echo "Renamed: '$file' to '$sanitized_file'"
    fi
  fi
}

dir_mode=false
dry_run=false

while getopts ":dnh" opt; do
  case "$opt" in
    d) dir_mode=true ;;
    n) dry_run=true ;;
    h) usage 0 ;;
    *)
      echo "Unknown option: -$OPTARG" >&2
      usage 1
      ;;
  esac
done
shift $((OPTIND - 1))

if $dir_mode; then
  for file in *; do
    sanitize_file "$file"
  done
elif [ $# -eq 0 ]; then
  usage 1
else
  for file in "$@"; do
    sanitize_file "$file"
  done
fi
