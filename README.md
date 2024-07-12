# macOS Setup Script

This script automates the setup of a new macOS development environment. It installs and configures various tools,
applications, and system preferences to create a consistent and productive workspace. Run
like `macos_developer_setup.sh`.

## Prerequisites

Before running the script, ensure you have:

1. macOS 10.15 (Catalina) or later
2. Administrative access to your Mac
3. Internet connection

## Environment Variables

The script requires the following environment variables to be set:

- `GIT_USER_NAME`: Your full name for Git commits
- `GIT_USER_EMAIL`: Your email address for Git commits
- `SSH_PRIVATE_KEY_PATH`: The path to your SSH private key file

Set these variables before running the script:

```bash
export GIT_USER_NAME='Your Name'
export GIT_USER_EMAIL='your.email@example.com'
export SSH_PRIVATE_KEY_PATH='/path/to/your/private/key'
```

## What the Script Does

1. Installs [Homebrew](https://brew.sh/), the package manager for macOS
2. Sets various macOS system preferences for improved usability
3. Installs Xcode Command Line Tools
4. Installs and configures various development tools and applications

### Installed Applications

The script installs the following applications via Homebrew Cask:

- [Docker](https://www.docker.com/)
- [JetBrains Mono Nerd Font](https://www.nerdfonts.com/)
- [ImageOptim](https://imageoptim.com/)
- [JetBrains Toolbox](https://www.jetbrains.com/toolbox-app/)
- [Slack](https://slack.com/)
- [Skype](https://www.skype.com/)
- [Vagrant](https://www.vagrantup.com/)
- [Vivid](https://www.getvivid.app/)
- [Zoom](https://zoom.us/)
- [Alacritty](https://alacritty.org/)

### Installed Command-Line Tools

The script installs these command-line tools via Homebrew:

- [Ansible](https://www.ansible.com/)
- [Bash](https://www.gnu.org/software/bash/) (latest version)
- [Bash Completion](https://github.com/scop/bash-completion)
- [Coreutils](https://www.gnu.org/software/coreutils/)
- [curl](https://curl.se/)
- [Git](https://git-scm.com/)
- [Git Delta](https://github.com/dandavison/delta)
- [GNU sed](https://www.gnu.org/software/sed/)
- [Packer](https://www.packer.io/)
- [Python](https://www.python.org/)
- [Terraform](https://www.terraform.io/)
- [Starship](https://starship.rs/)
- [Vim](https://www.vim.org/)
- [wget](https://www.gnu.org/software/wget/)
- [Zellij](https://zellij.dev/)

### Additional Configurations

- Sets up dotfiles from a GitHub repository
- Configures Git with the provided user name and email
- Installs Vagrant plugins: `vagrant-hostmanager` and `vagrant-vsphere`
- Updates the default shell to the latest version of Bash

## Usage

1. Set the required environment variables as described above.
2. Run the script:

   ```bash
   ./macos_setup.sh
   ```
3. Follow any additional instructions provided at the end of the script execution.

# dotfiles

These dotfiles are optimized for bash, zellij, vim, starship, and alacritty

The repo includes the vim plugin manager [Vundle](https://github.com/VundleVim/Vundle.vim) as a submodules, so make sure
to clone with `--recursive` or run `git submodule update --init --recursive` after cloning.

# Installation

## Manual

First, set the file modes for the files in the `.ssh` directory:

```
chmod 0600 .ssh/config
chmod 0600 .ssh/environment
```

Now, symlink all files to your home directory then install the Vim plugins by running:

```
vim --clean '+source ~/.vimrc' +PluginInstall +qall
```

## Automatic

Alternatively, you can use `symlinkctl` to do all of that for you:

```
./symlinkctl enable
```

And to remove the symlinks:

```
./symlinkctl disable
```

`symlinkctl` tries to be smart, portable, and non-destructive (eg, by backing up your existing files) but as with most
shell scripts, there are probably some configurations that will break it.

# Dependencies

The dotfiles expect all the binaries in the `REQUIRED_COMMANDS` variable to be installed and available in `$PATH`.
