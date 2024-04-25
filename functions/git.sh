#! /bin/bash

function find_commit {
  local commit_hash
  local query=$1
  commit_hash=$(
    git log --oneline |
      grep -v -e "Merge" |
      fzf --preview-label='[ Git Commit Preview ]' --preview='echo "#️⃣  Commit Hash: {1}\n💬 Commit Message:{2..}\n📄 Files Changed:\n$(git diff --name-only {1})\n" && git diff {1} | bat --color="always" --style="changes"' --with-nth='2..' --preview-window='up' --query="$query"
  ) &&
    echo "Selected commit: $commit_hash" | sed -Ee 's/ :[a-zA-Z]+://g' &&
    echo "$commit_hash" | awk '{print $1}' | pbcopy
}
