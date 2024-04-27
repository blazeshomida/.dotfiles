#! /bin/bash

# Dependencies:
# - fzf: A command-line fuzzy finder used for interactive search and selection.
# - bat: A cat clone with syntax highlighting and Git integration, used for previewing commit details.
# - diff-so-fancy: A human-readable diff formatter for Git, enhancing the visual presentation of changes.

# Description:
# This script streamlines the process of searching for a specific commit within a Git repository's history.
# It leverages fzf to provide an interactive search interface, allowing users to navigate through commit logs efficiently.
# Additionally, bat is employed to display a preview of the selected commit's details, enhancing readability with syntax highlighting.
# The diff-so-fancy tool further enhances the visualization of commit changes. With this script,
# users can seamlessly find and inspect commits, improving their Git workflow.
function find_commit {
  local commit_hash
  commit_hash=$(
    git log --format="__GIT__%h__MARKER__ %h %C(magenta)%ar %C(cyan)%s %b" --color="always" |
      awk 'BEGIN { RS="__GIT__[[:xdigit:]]{7}__MARKER__"; FS="\n";} {gsub(/\n/, ""); print }' |
      fzf --ansi --header-lines="1" --with-nth="2.." --nth='2..' --query="$1" \
        --cycle --no-sort --prompt='Search for a commit: ' \
        --padding='2' \
        --preview-label='[ Git Commit Preview ]' \
        --preview=" git show --no-patch {1} | 
          awk 'NR > 1 {
            if (NR >= 6) { gsub(/^[[:blank:]]+|[[:blank:]]+$/,\"\"); print }
            if (NR < 6 && !/^(Merge|Author|Date)/ && !/^[[:blank:]]*$/) { 
              gsub(/^[[:blank:]]+|[[:blank:]]+$/,\"\"); print
            }
          }' | 
          bat --style='plain' --color='always' --language='COMMIT_EDITMSG' && 
           git show --format='' {1} | 
          diff-so-fancy"
  ) &&
    echo "Selected commit: $commit_hash" | sed -E 's/ :[a-zA-Z]+://g' &&
    echo "$commit_hash" | awk '{print $1}' | pbcopy
}
