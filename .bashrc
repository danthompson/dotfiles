export EDITOR='vim'

alias rlu='sudo systemsetup -f -setremotelogin on && sudo systemsetup -f -getremotelogin'
alias rld='sudo systemsetup -f -setremotelogin off && sudo systemsetup -f -getremotelogin'
alias rl='sudo systemsetup -f -getremotelogin'

# Path additions
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/local/share/npm/bin:/usr/local/heroku/bin:$PATH
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export PATH="$HOME/.node_modules_global/bin:$PATH"
# export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# Grep default options
GREP_OPTIONS=
for pattern in .cvs .git .hg .svn .bundle log node_modules bower_components dist tmp; do
    GREP_OPTIONS="$GREP_OPTIONS --exclude-dir=$pattern --color"
done
export GREP_OPTIONS

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# nodenv
if which nodenv > /dev/null; then eval "$(nodenv init -)"; fi

# pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# Source auto completions
source /usr/local/etc/bash_completion.d/git-completion.bash
source /usr/local/etc/bash_completion.d/git-prompt.sh
source /usr/local/etc/bash_completion.d/aws_bash_completer

# ls
alias ls='ls -G'

# git
alias g='git'

# tmate
alias ta='tmux attach -t '
alias tn='tmux new -s '
alias tl='tmux ls'

# ruby
alias b='bundle'
alias be='bundle exec'

# heroku
alias h='heroku'

BIBlack="\[\033[1;90m\]"      # Black (Bold High Intensty)
IBlack="\[\033[0;90m\]"       # Black (High Intensty)
MAGENTA="\[\033[0;35m\]"
YELLOW="\[\033[0;33m\]"
BLUE="\[\033[34m\]"
LIGHT_GRAY="\[\033[0;37m\]"
CYAN="\[\033[0;36m\]"
GREEN="\[\033[0;32m\]"
RED="\[\033[0;31m\]"
LIGHT_RED="\[\033[1;31m\]"
RESET="\[\e[0m\]"
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true

export PS1=$IBlack"\u@\h"'$(
  if [[ $(__git_ps1) =~ \*\)$ ]]
  # a file has been modified but not added
  then echo "'$MAGENTA'"$(__git_ps1 " (%s)")
  elif [[ $(__git_ps1) =~ \+\)$ ]]
  # a file has been added, but not commited
  then echo "'$RED'"$(__git_ps1 " (%s)")
  # the state is clean, changes are commited
  else echo "'$CYAN'"$(__git_ps1 " (%s)")
  fi)'$YELLOW" \w"$RESET" $ "

# serve - Serves the current directory. Defaults to port 9090.
# Usage:
#   $ serve
#   $ serve 1234
function serve {
  port="${1:-9090}"
  ruby -run -e httpd . -p $port
}

# tmate/tmux pairing helpers
TMATE_PAIR_NAME="$(whoami)-pair"
TMATE_SOCKET_LOCATION="/tmp/tmate-pair.sock"
TMATE_TMUX_SESSION="/tmp/tmate-tmux-session"

# Get current tmate connection url
tmate-url() {
  url="$(tmate -S $TMATE_SOCKET_LOCATION display -p '#{tmate_ssh}')"
  echo "$url" | tr -d '\n' | pbcopy
  echo "Copied tmate url for $TMATE_PAIR_NAME:"
  echo "$url"
}

# Start a new tmate pair session if one doesn't already exist
# If creating a new session, the first argument can be an existing TMUX session to connect to automatically
tmate-pair() {
  if [ ! -e "$TMATE_SOCKET_LOCATION" ]; then
    tmate -S "$TMATE_SOCKET_LOCATION" -f "$HOME/.tmate.conf" new-session -d -s "$TMATE_PAIR_NAME"

    while [ -z "$url" ]; do
      url="$(tmate -S $TMATE_SOCKET_LOCATION display -p '#{tmate_ssh}')"
    done
    tmate-url
    sleep 1

    if [ -n "$1" ]; then
      echo $1 > $TMATE_TMUX_SESSION
      tmate -S "$TMATE_SOCKET_LOCATION" send -t "$TMATE_PAIR_NAME" "TMUX='' tmux attach-session -t $1" ENTER
    fi
  fi
  tmate -S "$TMATE_SOCKET_LOCATION" attach-session -t "$TMATE_PAIR_NAME"
}

# Close the pair because security
tmate-unpair() {
  if [ -e "$TMATE_SOCKET_LOCATION" ]; then
    if [ -e "$TMATE_SOCKET_LOCATION" ]; then
      tmux detach -s $(cat $TMATE_TMUX_SESSION)
      rm -f $TMATE_TMUX_SESSION
    fi

    tmate -S "$TMATE_SOCKET_LOCATION" kill-session -t "$TMATE_PAIR_NAME"
    echo "Killed session $TMATE_PAIR_NAME"
  else
    echo "Session already killed"
  fi
}
