export EDITOR='mvim -v'

# Path additions
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/local/share/npm/bin:/usr/local/heroku/bin:$PATH
export JAVA_HOME="/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home"
export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH

# Grep default options
GREP_OPTIONS=
for pattern in .cvs .git .hg .svn .bundle log node_modules bower_components dist tmp; do
    GREP_OPTIONS="$GREP_OPTIONS --exclude-dir=$pattern --color"
done
export GREP_OPTIONS

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Source auto completions
source /usr/local/etc/bash_completion.d/git-completion.bash
source /usr/local/etc/bash_completion.d/git-prompt.sh

alias e='vim'

# ls with colors
alias ls='ls -G'

# Git
alias g='git'

alias ta='tmux attach -t '
alias tn='tmux new -s '
alias tl='tmux ls'

# Gems
alias r='rails'
alias rdm='rake db:migrate'
alias rdp='rake db:test:prepare'
alias rr='rake routes'
alias b='bundle'
alias be='bundle exec'
alias h='heroku'
alias hc='heroku run console -a'
alias f='foreman'
alias gd='guard -cn f'

alias tdl='tail -f ./log/development.log'
alias cdl='> ./log/development.log'
alias ttl='tail -f ./log/test.log'
alias ctl='> ./log/test.log'

# Vim (MacVim in console)
alias vim='mvim -v'

# Postgres Up/Down
alias pgu='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pgd='pg_ctl -D /usr/local/var/postgres stop -s -m fast'

# Elastic Search
alias esu='launchctl load -F ~/Library/LaunchAgents/homebrew.mxcl.elasticsearch.plist'
alias esd='launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.elasticsearch.plist'

# Memcached
alias mcu='launchctl load -F ~/Library/LaunchAgents/homebrew.mxcl.memcached.plist'
alias mcd='launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.memcached.plist'

# Redis
alias rdu='launchctl load -F ~/Library/LaunchAgents/homebrew.mxcl.redis.plist'
alias rdd='launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.redis.plist'

alias mdu='launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist'
alias mdd='launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist'

# Nginx
alias ngu='launchctl load -F ~/Library/LaunchAgents/homebrew.mxcl.nginx.plist'
alias ngd='launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.nginx.plist'

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
export LS_OPTIONS='--color=auto'
export CLICOLOR='Yes'
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

export PS1=$LIGHT_GRAY"\u@\h"'$(
  if [[ $(__git_ps1) =~ \*\)$ ]]
  # a file has been modified but not added
  then echo "'$MAGENTA'"$(__git_ps1 " (%s)")
  elif [[ $(__git_ps1) =~ \+\)$ ]]
  # a file has been added, but not commited
  then echo "'$RED'"$(__git_ps1 " (%s)")
  # the state is clean, changes are commited
  else echo "'$CYAN'"$(__git_ps1 " (%s)")
  fi)'$YELLOW" \w"$RESET" $ "
