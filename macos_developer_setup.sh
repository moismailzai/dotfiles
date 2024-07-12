#!/bin/bash
set -euo pipefail

# Check for required environment variables
if [[ -z "${GIT_USER_NAME:-}" ]] || [[ -z "${GIT_USER_EMAIL:-}" ]] || [[ -z "${SSH_PRIVATE_KEY_PATH:-}" ]]; then
    echo "Error: Required environment variables are not set."
    echo "Please set the following environment variables and run the script again:"
    echo "  export GIT_USER_NAME='Your Name'"
    echo "  export GIT_USER_EMAIL='your.email@example.com'"
    echo "  export SSH_PRIVATE_KEY_PATH='/path/to/your/private/key'"
    exit 1
fi

# Verify that the SSH private key file exists
if [[ ! -f "$SSH_PRIVATE_KEY_PATH" ]]; then
    echo "Error: SSH private key file not found at $SSH_PRIVATE_KEY_PATH"
    echo "Please ensure the file exists and the path is correct."
    exit 1
fi

HOMEBREW_PREFIX=/opt/homebrew

# Function to run commands with error handling
run_command() {
    if ! "$@"; then
        echo "Error: Command '$*' failed"
        return 1
    fi
}

# Improved function to set macOS defaults
set_default() {
    domain=$1
    key=$2
    type=$3
    value=$4

    case $type in
        -string|-int|-float|-bool)
            run_command defaults write "$domain" "$key" "$type" "$value"
            ;;
        *)
            echo "Error: Invalid type '$type' for key '$key'"
            return 1
            ;;
    esac
}

# Ensure script is not run as root
if [[ $EUID -eq 0 ]]; then
   echo "This script must not be run as root"
   exit 1
fi

# Install Homebrew
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    run_command /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"' >> "$HOME/.bash_profile"
    eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"
else
    echo "Homebrew already installed."
fi

# Set macOS defaults
echo "Setting macOS defaults..."

# Show hidden files and volumes
run_command sudo chflags nohidden /Volumes
run_command chflags nohidden "$HOME/Library"

# Global domain defaults
set_default NSGlobalDomain AppleInterfaceStyle -string "Dark"
set_default NSGlobalDomain AppleKeyboardUIMode -int 3
set_default NSGlobalDomain ApplePressAndHoldEnabled -bool false
set_default NSGlobalDomain AppleShowAllExtensions -bool true
set_default NSGlobalDomain InitialKeyRepeat -int 15
set_default NSGlobalDomain KeyRepeat -int 2
set_default NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
set_default NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
set_default NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
set_default NSGlobalDomain com.apple.mouse.tapBehavior -int 1
set_default NSGlobalDomain com.apple.swipescrolldirection -bool false

# Finder preferences
set_default com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
set_default com.apple.finder ShowHardDrivesOnDesktop -bool true
set_default com.apple.finder ShowMountedServersOnDesktop -bool true
set_default com.apple.finder ShowRemovableMediaOnDesktop -bool true
set_default com.apple.finder FXEnableExtensionChangeWarning -bool false
set_default com.apple.finder FXPreferredViewStyle -string "Nlsv"
set_default com.apple.finder NewWindowTarget -string "PfDe"
set_default com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"

# Dock preferences
set_default com.apple.dock autohide -bool true
set_default com.apple.dock autohide-time-modifier -float 0.5

# Install developer tools
echo "Installing developer tools..."

# Install Xcode Command Line Tools
if ! xcode-select -p &> /dev/null; then
    echo "Installing Xcode Command Line Tools..."
    run_command xcode-select --install
else
    echo "Xcode Command Line Tools already installed."
fi

# Update Homebrew
echo "Updating Homebrew..."
run_command brew update

# Install Homebrew packages
echo "Installing Homebrew packages..."
brew_casks=(
    docker
    font-jetbrains-mono-nerd-font
    imageoptim
    jetbrains-toolbox
    slack
    skype
    vagrant
    vivid
    zoom
)

brew_formulae=(
    ansible
    bash
    bash-completion
    coreutils
    curl
    git
    git-delta
    gnu-sed
    packer
    python
    terraform
    starship
    vim
    wget
    zellij
)

run_command brew install -q --cask "${brew_casks[@]}"
run_command brew install -q --cask --no-quarantine alacritty
run_command brew install -q "${brew_formulae[@]}"

# Set up dotfiles
echo "Setting up dotfiles..."
mkdir -p "$HOME/.ssh/control"

if [ ! -d "$HOME/dotfiles" ]; then
    run_command git clone --recursive https://github.com/moismailzai/dotfiles "$HOME/dotfiles"
fi

# Copy SSH private key
echo "Copying SSH private key..."
run_command cp "$SSH_PRIVATE_KEY_PATH" "$HOME/.ssh/"
run_command chmod 600 "$HOME/.ssh/$SSH_PRIVATE_KEY_PATH"

# Configure Git
echo "Configuring Git..."
run_command git config --global user.name "$GIT_USER_NAME"
run_command git config --global user.email "$GIT_USER_EMAIL"
run_command git config --global init.defaultBranch main

# Update shell
echo "Updating shell..."
echo "$HOMEBREW_PREFIX/bin/bash" | sudo tee -a /etc/shells
chsh -s $HOMEBREW_PREFIX/bin/bash

# Install Vagrant plugins
echo "Installing Vagrant plugins..."
run_command vagrant plugin install vagrant-hostmanager
run_command vagrant plugin install vagrant-vsphere

# Print final instructions
cat << EOF

Setup complete! Additional steps to take:

1. Set up proper diff tracking in JetBrains:
   - Go to Help > Edit Custom VM Options
   - Add: -Didea.case.sensitive.fs=true
   - Run: git config --global --add safe.directory ~/dev/boxes/sgs/www (or your project path)

2. Set up dotfiles:
   - cd ~/dotfiles
   - Run: source .bash_exports && ./symlinkctl enable

3. Exit terminal and run alacritty.

Please reboot your system to ensure all changes take effect.
EOF
