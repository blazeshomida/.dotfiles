#! /bin/bash

# Define a function to find a git commit using an interactive filter.
function find_commit {
  # Declare a local variable for the commit hash.
  local commit_hash
  # Use git log to get commits, format them, and pipe to fzf for interactive selection.
  commit_hash=$(
    git log --oneline --color="always" --format="%C(magenta)%h %C(cyan)%s" | # Format commit hash and message with colors.

      # fzf to filter commits based on query input.
      # Preview command showing commit details.
      # Use diff-so-fancy for a nicer diff display.
      fzf --ansi --nth="2.." --query="$1" \
        --cycle --prompt='Search for a commit: ' \
        --padding='2' \
        --preview-label='[ Git Commit Preview ]' \
        --preview='git show {1} --no-patch | 
            bat --color="always" --style="grid,snip" && 
            git show {1} --format="" | 
            diff-so-fancy'
  ) &&
    # Proceed if the selection was successful.
    # Output the selected commit hash.
    echo "Selected commit: $commit_hash" | sed -Ee 's/ :[a-zA-Z]+://g' &&
    # Copy the pure commit hash to the clipboard for easy pasting.
    echo "$commit_hash" | awk '{print $1}' | pbcopy
}

# This script allows the user to interactively search and select a git commit from the log.
# The selected commit hash is displayed and copied to the clipboard.
