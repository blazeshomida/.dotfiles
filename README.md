# @blazeshomida/.dotfiles

## Instructions

First clone the repo into your home directory.

```sh
git clone https://github.com/blazeshomida/.dotfiles.git ~/.dotfiles
```

### Using `bootstrap.sh`

- Make `bootstrap.sh` an executable.

```sh
chmod +x $HOME/.dotfiles/bootstrap.sh
```

> If your `.dotfiles` directory is not inside `$HOME`, make sure to update both this command and the `bootstrap.sh` `$DOTFILES_DIR` variable.

The `bootstrap.sh` script automates the setup process by creating symbolic links for your dotfiles and configurations. Here's what it does:

- **Creating Symbolic Links for Dotfiles**: It creates symbolic links for the following dotfiles in your home directory:
  - `.profile`
  - `.zshrc`
  - `.zprofile`
  - `.bashrc`

- **Checking Homebrew Installation**: It checks if Homebrew is installed. If not, it installs Homebrew.

- **Installing Homebrew Packages**: It installs packages listed in the `Brewfile` located in your `.dotfiles` directory using Homebrew bundle.

- **Creating Symbolic Links for Other Configurations**: It creates symbolic links for other configurations such as:
  - `.config`
  - `.gitconfig`
  - `vscode/settings.json`
  - `vscode/keybindings.json`

> If the destination already has files, you'll get a warning to manually remove the existing file/directory in order to create the link.