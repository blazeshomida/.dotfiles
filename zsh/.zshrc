# CodeWhisperer pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh"

function for_each {
  local condition=$1
  local action=$2
  shift 2 # Remove the first two arguments (condition and action)
  local items=("$@")

  for item in "${items[@]}"; do
    if $condition "$item"; then
      $action "$item"
    else
      echo "Skipping: '$item' does not meet the condition: $condition"
    fi
  done
}

function is_file {
  [[ -f $1 ]]
}

function exists {
  [[ -e $1 ]]
}

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"

# Usage of globbing instead of parsing ls output
if [[ -d "$HOME/.dotfiles" ]]; then
  source "$HOME/.dotfiles/aliases.sh"
  local fn_dir=("$HOME/.dotfiles/functions"/**/*)
  for_each is_file source "${fn_dir[@]}"
else
  echo "Please move .dotfiles to $HOME or update the paths in .zshrc"
fi

# Must be at the end:
# https://formulae.brew.sh/formula/zsh-autosuggestions
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# https://formulae.brew.sh/formula/zsh-syntax-highlighting
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# CodeWhisperer post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh"
