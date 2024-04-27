# $DOTFILES_DIR comes from .zprofile which gets loaded before zshrc

# CodeWhisperer pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh"

function for_each {
  local condition=$1
  local command=$2
  shift 2 # Remove the condition and command from the arguments list
  local items=("$@")

  for item in "${items[@]}"; do
    # Check the condition with the item using eval with careful quoting
    if eval "$condition"; then
      # Execute the command with the item if the condition is true
      eval "$command "
    fi
  done
}

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"

# Usage of globbing instead of parsing ls output
if [[ -d "$DOTFILES_DIR" ]]; then
  source "$DOTFILES_DIR/aliases.sh"
  local fn_dir=("$DOTFILES_DIR/functions"/**/*)
  for_each '[[ -f $item ]]' 'source $item' "${fn_dir[@]}"
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
