# CodeWhisperer pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh"

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(starship init zsh)"     
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"

alias load_zsh='source ~/.zshrc'
alias get_brew_formula='brew leaves | cat'
alias get_brew_cask='brew ls --cask | cat'
alias get_brew='echo "# HOMEBREW\n## Formula" && get_brew_formula && echo "\n## Cask" && get_brew_cask'

# Must be at the end: 
# https://formulae.brew.sh/formula/zsh-autosuggestions
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# https://formulae.brew.sh/formula/zsh-syntax-highlighting
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# pnpm
export PNPM_HOME="/Users/shomida_dev/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

alias pn='pnpm'
alias px='pnpm dlx'
# pnpm end

# CodeWhisperer post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh"



