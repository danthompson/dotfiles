#!/usr/bin/env bash

# Check if at least one argument (the CLI name) is provided
if [ -z "$1" ]; then
  echo "Error: Missing CLI command."
  echo "Usage: $0 <cli_name> [subcommand1] [subcommand2] ..."
  echo "Example: $0 uv help version auth run init add remove"
  exit 1
fi

# Assign the first argument as the CLI command
CLI_CMD="$1"
OUT_FILE="${CLI_CMD}.txt"

# Shift the arguments so $@ now only contains the subcommands
shift

# Clear the file if it exists, or create an empty one
> "$OUT_FILE"

echo "Generating documentation for '$CLI_CMD'..."

echo -e "$CLI_CMD \n\n" >> "$OUT_FILE"

# If no subcommands were provided, just run the base help
if [ "$#" -eq 0 ]; then
  echo "No subcommands provided. Dumping base help..."
  echo -e "=== Output for: $CLI_CMD --help ===" >> "$OUT_FILE"
  $CLI_CMD --help >> "$OUT_FILE" 2>&1
  echo "Done! Output saved to $OUT_FILE"
  exit 0
fi

# Iterate through all provided subcommands
for cmd in "$@"; do
  echo "Processing: $CLI_CMD $cmd"
  echo -e "\n=== Output for: $CLI_CMD $cmd ===" >> "$OUT_FILE"

  # If the command is 'help', just run it. Otherwise, append '--help'
  if [ "$cmd" = "help" ]; then
    $CLI_CMD "$cmd" >> "$OUT_FILE" 2>&1
  else
    $CLI_CMD "$cmd" --help >> "$OUT_FILE" 2>&1
  fi
done

echo "Done! Output successfully saved to $OUT_FILE"
