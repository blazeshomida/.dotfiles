#!/bin/bash

# Set the directory where dotfiles are stored
DOTFILES_DIR="$HOME/.dotfiles"

# Function to create symbolic links
function create_symlink() {
    # Get the source and destination paths
    local source=$1
    local destination=$2

    # Extract filenames from paths
    local src_filename
    src_filename=$(basename "$source")
    local dest_filename
    dest_filename=$(basename "$destination")

    # Define color codes for colorful output
    RED=$(tput setaf 1)
    GREEN=$(tput setaf 2)
    YELLOW=$(tput setaf 3)
    TEAL=$(tput setaf 6)
    NC=$(tput sgr0) # No Color

    # Check if the source file exists
    if [ ! -e "$source" ]; then
        echo "${RED}Error:${NC} Source '$src_filename' does not exist."
        return 1
    fi

    # Check if the destination already exists
    if [ -e "$destination" ]; then
        # Check if the destination is a symbolic link
        if [ -L "$destination" ]; then
            # Check if the destination points to the same source file
            if [ "$(readlink "$destination")" = "$source" ]; then
                echo "${TEAL}Note:${NC} Destination '$dest_filename' is already linked to '$src_filename'. Skipping."
                return 0
            else
                echo "${YELLOW}Warning:${NC} '$dest_filename' is a symbolic link but points to a different source. Consider manual intervention."
                return 1
            fi
        else
            echo "${YELLOW}Warning:${NC} '$dest_filename' already exists and is not a link. Consider manual intervention."
            return 1
        fi
    else
        # Create symbolic link if destination doesn't exist
        ln -sn "$source" "$destination"
        echo "${GREEN}Success:${NC} Created symbolic link '${TEAL}$dest_filename${NC}'"
    fi
}


function is_valid_dir_item() {
    local item=$1
    # Checks if valid item; not to match */. or */.. or /*
    [[ -f "$item" || -d "$item" ]] && ! [[ "$item" =~ \.\.?$|\*$ ]]
}

# Function to create symlinks for files in a directory
function create_symlinks_in_dir() {
    local directory=$1
    local destination=$2

    for item in "$directory"/{.,}*; do
        if is_valid_dir_item "$item" && is_valid_dir_item "$destination"; then
            create_symlink "$item" "$destination/$(basename "$item")"
        fi
    done
}

# Function to print section titles and separators
function print_section() {
    local title=$1
    echo "-------------------"
    echo "$title"
    echo "-------------------"
}

function setup_shell() {
    print_section "Creating symbolic links for dotfiles"
    create_symlink "$DOTFILES_DIR/.profile" "$HOME/.profile"
    create_symlink "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
    create_symlinks_in_dir "$DOTFILES_DIR/zsh" "$HOME"
}

function setup_package_manager() {
    print_section "Checking Homebrew installation"
    if ! command -v brew &>/dev/null; then
        echo "Homebrew not found. Installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo "Homebrew found. Skipping installation."
    fi
    print_section "Installing Homebrew packages"
    brew bundle --file "$DOTFILES_DIR/Brewfile"
}

function setup_configs() {
    print_section "Creating symbolic links for other configurations"
    create_symlink "$DOTFILES_DIR/.config" "$HOME/.config"
    create_symlink "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
    create_symlinks_in_dir "$DOTFILES_DIR/vscode" "$HOME/Library/Application Support/Code/User"
}

function main() {
    setup_shell
    setup_package_manager
    setup_configs
}

main
