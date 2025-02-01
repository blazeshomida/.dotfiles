#!/usr/bin/env bash

# TODO: Cleanup unused styles

# ---------------
# Text Formatting
# ---------------
RESET="\033[0m"
BOLD="\033[1m"
ITALIC="\033[3m"
UNDERLINE="\033[4m"

# ---------------
# Text Colors
# ---------------
BLACK="\033[30m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
MAGENTA="\033[35m"
CYAN="\033[36m"
WHITE="\033[37m"

# ---------------
# Background Colors
# ---------------
BG_BLACK="\033[40m"
BG_RED="\033[41m"
BG_GREEN="\033[42m"
BG_YELLOW="\033[43m"
BG_BLUE="\033[44m"
BG_MAGENTA="\033[45m"
BG_CYAN="\033[46m"
BG_WHITE="\033[47m"

# -----------------
# Logging Functions
# -----------------
log_info() { echo -e "${CYAN}[INFO]${RESET} $1"; }
log_debug() { echo -e "${MAGENTA}[DEBUG]${RESET} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${RESET} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${RESET} $1"; }
log_error() { echo -e "${RED}[ERROR]${RESET} $1"; }
highlight() { printf "${CYAN}$1${RESET}"; }
highlight "
+-------------------------------------------------------------------------------------------------------------+
|                                                                                                             |
|     ██████╗ ██╗      █████╗ ███████╗███████╗    ███████╗██╗  ██╗ ██████╗ ███╗   ███╗██╗██████╗  █████╗      |
|     ██╔══██╗██║     ██╔══██╗╚══███╔╝██╔════╝    ██╔════╝██║  ██║██╔═══██╗████╗ ████║██║██╔══██╗██╔══██╗     |
|     ██████╔╝██║     ███████║  ███╔╝ █████╗      ███████╗███████║██║   ██║██╔████╔██║██║██║  ██║███████║     |
|     ██╔══██╗██║     ██╔══██║ ███╔╝  ██╔══╝      ╚════██║██╔══██║██║   ██║██║╚██╔╝██║██║██║  ██║██╔══██║     |
|     ██████╔╝███████╗██║  ██║███████╗███████╗    ███████║██║  ██║╚██████╔╝██║ ╚═╝ ██║██║██████╔╝██║  ██║     |
|     ╚═════╝ ╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝    ╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚═╝╚═════╝ ╚═╝  ╚═╝     |
|                                                                                                             |
+-------------------------------------------------------------------------------------------------------------+
|                                        Dotfiles Setup                                                       |
+-------------------------------------------------------------------------------------------------------------+
"

# TODO: Test with other OS
# NOTE: Only tested with MacOs (Darwin) currently
get_os() {
    uname -s
}

# TODO: Add additional package managers
get_pm() {
    local os=$1
    case "$os" in
    "Darwin") echo "Homebrew" ;;
    *) echo "Unknown" ;;
    esac
}

# Check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# TODO: Additional package management strategy
install_packages() {
    local os
    os=$(get_os)
    log_info "Detected OS: $(highlight "$os")"
    local pm
    pm=$(get_pm "$os")
    log_info "Installing packages from: $(highlight "$pm")"

    local packages
    packages=(
        # CLI Utilities
        "bat"     # Clone of cat(1) with syntax highlighting and Git integration
        "eza"     # Modern, maintained replacement for ls
        "fzf"     # Command-line fuzzy finder written in Go
        "ripgrep" # Search tool like grep and The Silver Searcher
        "tldr"    # Simplified and community-driven man pages
        "zoxide"  # Shell extension to navigate your filesystem faster

        # Development Tools
        "docker"                # Pack, ship and run any application as a lightweight container
        "gh"                    # GitHub command-line tool
        "git"                   # Distributed revision control system
        "node"                  # Platform built on V8 to build network applications
        "pnpm"                  # Fast, disk space efficient package manager
        "supabase/tap/supabase" # Supabase CLI

        # Shell & Terminal Enhancements
        "fnm"        # Fast and simple Node.js version manager
        "neovim"     # Ambitious Vim-fork focused on extensibility and agility
        "shellcheck" # Static analysis and lint tool for (ba)sh scripts
        "shfmt"      # Autoformat shell script source code
        "starship"   # Cross-shell prompt for astronauts
        "stow"       # Organize software neatly under a single directory tree (e.g. /usr/local)
        "tmux"       # Terminal multiplexer
    )

    case "$pm" in
    "Homebrew")
        if ! command_exists "brew"; then
            echo "Homebrew Not Installed"
        fi
        brew bundle install --file=./Brewfile
        log_success "Homebrew packages installed successfully"
        ;;
    *) echo "Unknown" ;;
    esac
}

main() {
    log_info "Starting setup..."
    install_packages "$pm"
    # TODO: Stow packages
}

main

