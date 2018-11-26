export ANDROID_SDK_ROOT="/usr/local/share/android-sdk"

# Load rbenv automatically (https://github.com/rbenv/rbenv#homebrew-on-mac-os-x)
if [ $(which rbenv) ]; then
  eval "$(rbenv init -)"
fi

# Load byobu prefix if installed
if [ $(which byobu) ]; then
  export BYOBU_PREFIX=/usr/local
fi

# Source all .dot files, starting with .extra, which shouldn't be committed
for file in ~/.{extra,bash_prompt,exports,aliases}; do
  if [ -f $file ]; then
      [ -r "$file" ] && source "$file"
  fi
done
unset file

# Brew bash completion
if [ -f /usr/local/share/bash-completion/bash_completion ]; then
  . /usr/local/share/bash-completion/bash_completion
fi

# Prompt fix for Gnome
if [ -z "$COLORTERM" ] && cat /proc/$PPID/exe 2> /dev/null | grep -q gnome-terminal; then
     export COLORTERM=gnome-terminal
fi

# highlighting inside manpages and elsewhere
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

# realtime bash_history, with timestamps
export HISTTIMEFORMAT='%F %T '
export HISTCONTROL=ignoredups:erasedups         # no duplicate entries
export HISTSIZE=100000                          # big big history (default is 500)
export HISTFILESIZE=$HISTSIZE                   # big big history
type shopt &> /dev/null && shopt -s histappend  # append to history, don't overwrite it
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;
export PATH="/usr/local/opt/heimdal/sbin:$PATH"
export PATH="~/go/bin:$PATH"
_byobu_sourced=1 . /usr/local/Cellar/byobu/5.127/bin/byobu-launch 2>/dev/null || true
