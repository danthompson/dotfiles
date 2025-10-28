#!/bin/bash

usage() {
  cat <<EOF
Usage: $(basename "$0") [-d] [-n] [-f] [file ...]

Convert HTML files to GitHub-Flavored Markdown using pandoc.
For each 'name.html', writes 'name.html.md' alongside it.

Options:
  -d    Convert all *.html files in the current directory
  -n    Dry run (show pandoc commands without running them)
  -f    Overwrite existing .html.md output files
  -h    Show this help message

Arguments:
  file  One or more HTML files to convert
EOF
  exit "${1:-0}"
}

convert_file() {
  local file="$1"

  [ -f "$file" ] || {
    echo "Skipping: '$file' (not a regular file)" >&2
    return 1
  }

  case "$file" in
    *.html) ;;
    *)
      echo "Skipping: '$file' (not an .html file)" >&2
      return 1
      ;;
  esac

  local output="${file%.html}.html.md"

  if [ -e "$output" ] && ! $force; then
    echo "Skipping: '$output' already exists (use -f to overwrite)" >&2
    return 1
  fi

  if $dry_run; then
    echo "Would run: pandoc --from html --to gfm-raw_html --output '$output' '$file'"
  else
    if pandoc --from html --to gfm-raw_html --output "$output" "$file"; then
      echo "Converted: '$file' to '$output'"
    else
      echo "Failed: '$file'" >&2
      return 1
    fi
  fi
}

dir_mode=false
dry_run=false
force=false

while getopts ":dnfh" opt; do
  case "$opt" in
    d) dir_mode=true ;;
    n) dry_run=true ;;
    f) force=true ;;
    h) usage 0 ;;
    *)
      echo "Unknown option: -$OPTARG" >&2
      usage 1
      ;;
  esac
done
shift $((OPTIND - 1))

command -v pandoc >/dev/null 2>&1 || {
  echo "Error: pandoc not found in PATH" >&2
  exit 1
}

if $dir_mode; then
  shopt -s nullglob
  files=(*.html)
  shopt -u nullglob
  if [ ${#files[@]} -eq 0 ]; then
    echo "No *.html files in current directory" >&2
    exit 1
  fi
  for file in "${files[@]}"; do
    convert_file "$file"
  done
elif [ $# -eq 0 ]; then
  usage 1
else
  for file in "$@"; do
    convert_file "$file"
  done
fi
