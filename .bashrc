#!/bin/bash

# source all .dot files
for file in ~/.{bash_exports,bash_functions,bash_aliases,bash_prompt,bash_local}; do
  if [[ -f "$file" ]]; then
      [[ -r "$file" ]] && source "$file"
  fi
done
unset file

# ensure the userspace programs we expect are installed
check_for_userspace_commands

# Export LS_COLORS after we've sourced everything else and have an updated $PATH
if command -v vivid &> /dev/null; then
    LS_COLORS="$(vivid generate tokyonight-moon)"
    export LS_COLORS
else
    echo "vivid is not installed. Please install it for custom LS_COLORS."
fi

# linux
if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
fi

# mac
if [ -f "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh" ]; then
  . "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh"
fi

# allow local connections to X as root
if xset q &>/dev/null; then
  xhost local:root > /dev/null 2>&1
fi

# configure some bash options
# see https://www.gnu.org/software/bash/manual/bash.html
shopt -s cdspell        # Autocorrect typos in path names when using `cd`
shopt -s checkwinsize   # Check the window size after each command
shopt -s cmdhist        # Save multi-line commands as one command
shopt -s expand_aliases # Expand aliases
shopt -s histappend     # Append to the history file, don't overwrite it
shopt -s nocaseglob     # Case-insensitive globbing (used in pathname expansion)
shopt -s globstar       # Recursive globbing, e.g. **/*.txt
