# CodeWhisperer pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zprofile.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zprofile.pre.zsh"

export EDITOR='code'
# Custom MANPAGER setup: Formats man page output with 'col -bx' to clean and expand format characters,
# then uses 'bat -l man -p' to add syntax highlighting, enhancing readability and visual appeal of man pages.
export MANPAGER="col -bx | bat -l man -p"

# CodeWhisperer post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zprofile.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zprofile.post.zsh"
