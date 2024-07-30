#!/bin/bash

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~"
alias -- -="cd -"  # Go to previous directory

# File operations - prevent accidental overwriting
alias mv='mv -iv'
alias rm='rm -iv'
alias cp='cp -iv'
alias ln='ln -iv'

# Detect if GNU ls is available
if ls --color=auto &> /dev/null; then
    # GNU ls
    alias ls='ls --color=auto -a'
    alias ll='ls -lh --color=auto'
    alias la='ls -lah --color=auto'
    alias l='ls -CF --color=auto'
else
    # BSD ls (macOS default)
    export CLICOLOR=1
    export LSCOLORS=GxFxCxDxBxegedabagaced
    alias ls='ls -G'
    alias ll='ls -lhG'
    alias la='ls -lahG'
    alias l='ls -CFG'
fi

# colorize things
alias ls='ls --color=auto -a'
alias lsd='ls --color=always -al | grep "^d"'
alias ll='ls -ahl'
alias grep='grep --colour=auto'

alias lsd='ls -l | grep "^d"'  # List only directories
alias l.='ls -d .* --color=auto'  # List only hidden files

# Colorize grep output
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Colorize diff output
alias diff='diff --color=auto'

# Quick access to config files
alias vimrc='$EDITOR ~/.vimrc'
alias bashrc='$EDITOR ~/.bashrc'
alias reload='source ~/.bashrc'  # Reload bash configuration

# System information
alias meminfo='free -m -l -t'
alias cpuinfo='lscpu'

# Network
alias ip='ip -color=auto'
alias ping='ping -c 5'  # Stop after sending 5 packets

# Safety nets
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# Git aliases
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gs='git status'
alias gd='git diff'
alias gl='git log --oneline --graph --decorate'

# Docker aliases
alias dps='docker ps'
alias dpa='docker ps -a'
alias di='docker images'
alias dex='docker exec -it'  # Usage: dex container_name command

# Misc
alias path='echo -e ${PATH//:/\\n}'  # Pretty-print PATH

# macOS specific aliases
if [[ "$OSTYPE" == "darwin"* ]]; then
    alias showfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
    alias hidefiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
    alias updatedb='sudo /usr/libexec/locate.updatedb'
    alias flushdns='sudo killall -HUP mDNSResponder'
fi

# Python aliases
alias py='python3'
alias pip='pip3'

# Improved mkdir
alias mkdir='mkdir -pv'  # Create parent directories, verbose

# Quick edit
alias edit='$EDITOR'  # Open in default editor

# Shortcut for finding files
alias f='find . -name'  # Usage: f "*.txt"

# Show open ports
alias ports='netstat -tulanp'
