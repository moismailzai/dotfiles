# macOS Setup Script

This script automates the setup of a new macOS development environment. It installs and configures various tools,
applications, and system preferences to create a consistent and productive workspace. Run
like `macos_developer_setup.sh`.

## Prerequisites

Before running the script, ensure you have:

1. macOS 10.15 (Catalina) or later
2. Administrative access to your Mac
3. Internet connection

## What the Script Does

1. Installs [Homebrew](https://brew.sh/), the package manager for macOS
2. Sets various macOS system preferences for improved usability
3. Installs Xcode Command Line Tools
4. Installs and configures various development tools and applications

# Installation
## 1. Set Environment Variables

The script requires the following environment variables to be set in your local environment.

- `GIT_USER_NAME`: Your full name for Git commits
- `GIT_USER_EMAIL`: Your email address for Git commits
- `SSH_PRIVATE_KEY_PATH`: The path to your SSH private key file

To set them, open a command line terminal and run the following commands, replacing the placeholders with your actual
values:

```bash
export GIT_USER_NAME='Your Name'
export GIT_USER_EMAIL='your.email@example.com'
export SSH_PRIVATE_KEY_PATH='/path/to/your/private/key'
```

This assumes you already have a private key file in the `~/.ssh` directory. If you don't, you can generate one using
the following command:

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

This will create a new SSH key, using the provided email as a label. When prompted to "Enter a file in which to save the
key," press Enter. This accepts the default file location. When prompted, type a secure passphrase.

## 2. Run the Script

This script is intended to be run on a new macOS installation. The best way to run it is to download the script to your
local machine and execute it from the command line, since your machine may not have Git installed yet. The script will
need to be flagged as executable before it can be run, which you can do with the following command:

```bash
chmod +x macos_developer_setup.sh
```

Once the script is executable, you can run it by executing the following command. Make sure that the environment
variables are set before running the script (they will not be set if you close the terminal window after setting them).

```bash
./macos_developer_setup.sh
````

Once the script completes, there will be additional steps to complete the setup. Follow the instructions in the terminal.

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