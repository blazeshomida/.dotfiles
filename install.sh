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

echo -e "${CYAN}
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
${RESET}"

# TODO: Test with other OS
# NOTE: Only tested with MacOs (Darwin) currently
get_os() {
        echo $(uname -s)
}

# TODO: Add additional package managers
get_pm() {
        local os=$1
        case "$os" in
                Darwin) echo Homebrew ;;
                *) echo Unknow ;;
        esac

}

main() {
        log_info "Starting setup..."
        local os=$(get_os)
        log_info "Detected OS: ${BOLD}${CYAN}$os${RESET}"
        local pm=$(get_pm $os)
        log_info "Detected Package Manager: ${BOLD}${CYAN}$pm"
        # TODO: Install packages
        # TODO: Stow packages
}

main
