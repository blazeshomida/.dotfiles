#!/bin/bash

# Set the directory where dotfiles are stored
DOTFILES_DIR="$HOME/.dotfiles"

# Function to create symbolic links
create_symlink() {
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
                echo "Destination '${TEAL}$dest_filename${NC}' is already a symbolic link to '${TEAL}.dotfiles/$src_filename${NC}'. Skipping."
                return 0
            fi

        fi

        # Display a warning message if the destination exists
        echo "${YELLOW}Warning:${NC} '${YELLOW}$dest_filename${NC}' already exists."

        # Display contents of the current file/destination if they are different
        if [ -f "$destination" ]; then
            echo "Current content of '$dest_filename':"
            # Diff the source and destination files, highlighting differences with color
            diff_output=$(diff --unified=0 --color=always "$source" "$destination")
            if [ -n "$diff_output" ]; then
                echo "$diff_output"
            fi
        elif [ -d "$destination" ]; then
            echo "Current content of '$dest_filename' directory:"
            # Diff the source and destination directories, highlighting differences with color
            diff_output=$(diff --recursive --unified=0 --color=always "$source" "$destination")
            if [ -n "$diff_output" ]; then
                echo "$diff_output"
            fi
        fi

        # Prompt user for action
        read -rp "Do you want to overwrite (o), append (a), or cancel (c)? " choice
        case "$choice" in
        o | O)
            # Overwrite the existing destination
            ln -snf "$source" "$destination"
            echo "${GREEN}Success:${NC} Overwrote existing destination '${TEAL}$dest_filename${NC}'"
            ;;
        a | A)
            # Append the existing destination if it's a directory
            if [ -d "$destination" ]; then
                # Copy the contents of the destination directory to the source directory
                cp -r "$destination"/* "$source"
                # Update the symbolic link
                ln -snf "$source" "$destination"
                echo "${GREEN}Success:${NC} Appended existing directory '${TEAL}$dest_filename${NC}'"
            else
                # Append the contents of the destination file to the source file
                cat "$destination" >>"$source"
                # Update the symbolic link
                ln -snf "$source" "$destination"
                echo "${GREEN}Success:${NC} Appended existing file '${TEAL}$dest_filename${NC}'"
            fi
            ;;
        *)
            # Cancel the operation
            echo "Operation canceled."
            ;;
        esac
    else
        # Create symbolic link if destination doesn't exist
        ln -sn "$source" "$destination"
        echo "${GREEN}Success:${NC} Created symbolic link '${TEAL}$dest_filename${NC}'"
    fi
}

# Function to create symlinks for files in a directory
create_symlinks_in_dir() {
    local directory=$1
    local destination=$2

    for file in "$directory"/*; do
        create_symlink "$file" "$destination/$(basename "$file")"
    done
}

# Function to print section titles and separators
print_section() {
    local title=$1
    echo "-------------------"
    echo "$title"
    echo "-------------------"
}

print_section "Creating symbolic links for dotfiles"
create_symlink "$DOTFILES_DIR/.profile" "$HOME/.profile"
create_symlink "$DOTFILES_DIR/zsh/.zprofile" "$HOME/.zprofile"
create_symlink "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
create_symlink "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"

print_section "Checking Homebrew installation"
if ! command -v brew &>/dev/null; then
    echo "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew found. Skipping installation."
fi

print_section "Installing Homebrew packages"
brew bundle --file "$DOTFILES_DIR/Brewfile"

print_section "Creating symbolic links for other configurations"
create_symlink "$DOTFILES_DIR/.config" "$HOME/.config"
create_symlink "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
create_symlinks_in_dir "$DOTFILES_DIR/vscode" "$HOME/Library/Application Support/Code/User"

print_section "Installing Typescript"
pnpm install --global typescript
