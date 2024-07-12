#!/bin/bash

# ensure the userspace programs we expect are installed
check_for_userspace_commands() {
  for COMMAND in alacritty awk date delta git grep logname ps readlink sed starship tput uname vim vivid zellij; do
    if ! command -v $COMMAND >/dev/null 2>&1; then
      echo "The userspace program '$COMMAND' is missing, please install it."
    fi
  done
}

# extract archives
ex() {
  if [ -f "$1" ]; then
    case "$1" in
    *.tar.bz2) tar xjf "$1" ;;
    *.tar.gz) tar xzf "$1" ;;
    *.bz2) bunzip2 "$1" ;;
    *.rar) unrar x "$1" ;;
    *.gz) gunzip "$1" ;;
    *.tar) tar xf "$1" ;;
    *.tbz2) tar xjf "$1" ;;
    *.tgz) tar xzf "$1" ;;
    *.zip) unzip "$1" ;;
    *.Z) uncompress "$1" ;;
    *.7z) 7z x "$1" ;;
    *) echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

function start_zellij() {
    # Check if Zellij is installed
    if ! command -v zellij &> /dev/null; then
        echo "Zellij is not installed. Please install it first."
        return 1
    fi

    # Check if a Zellij session named "main" exists
    if zellij list-sessions 2>/dev/null | grep -q "main"; then
        # If it exists, attach to it
        zellij attach main
    else
        # If it doesn't exist, create a new session named "main"
        zellij --session main
    fi
}
