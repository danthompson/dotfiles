#!/bin/bash
# shellcheck disable=SC1090
# shellcheck disable=SC2034

shopt -s cdspell # autocorrect typos in path names
shopt -s checkwinsize
shopt -s histappend # append history
shopt -s nocaseglob # case insensitive globbing

test -r "/etc/bash_completion" && source "$_"
test -r "/usr/local/etc/bash_completion.d/.aws_bash_completer" && source "$_"
test -r "/usr/local/etc/bash_completion.d/git-completion.sh" && source "$_"
test -r "/usr/local/etc/bash_completion.d/git-prompt.sh" && source "$_"
test -r "/usr/local/opt/fzf/shell/completion.bash" && source "$_"
test -r "/usr/local/opt/fzf/shell/key-bindings.bash" && source "$_"


# Path additions
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/local/share/npm/bin:/usr/local/heroku/bin:$PATH
# export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export PATH="$HOME/.node_modules_global/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
# export JAVA_HOME="/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home"
# export PATH="$JAVA_HOME:$PATH"

export EDITOR='vim'
export FZF_DEFAULT_COMMAND='rg --files --ignore --hidden --follow --glob "!{.keep,.bundle,.git,node_modules,temp}/*" --glob "!{*.meta,*.asset}"'
export FZF_DEFAULT_OPTS='--no-height'
export HISTCONTROL='ignoredups:erasedups:ignorespace'
export HISTFILESIZE='100000'
export HISTIGNORE="fg*"
export HISTSIZE='100000'
export HISTTIMEFORMAT="%Y/%m/%d %H:%M:%S:  "
export LSCOLORS='ExGxFxdxCxDxDxHBhDhCgC'
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
export PAGER='less'
export SHELL_SESSION_HISTORY='0'
export MANPAGER='less -X'

alias b='bundle'
alias g='git'
alias ls='ls -G'

if command -v nodenv > /dev/null; then eval "$(nodenv init -)"; fi
if command -v pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if command -v rbenv > /dev/null; then eval "$(rbenv init -)"; fi

PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

GIT_PS1_DESCRIBE_STYLE=branch # detached-head description
GIT_PS1_SHOWCOLORHINTS=true # colors (only PROMPT_COMMAND)
GIT_PS1_SHOWDIRTYSTATE=true # working directory state (* modified/+ staged)
GIT_PS1_SHOWSTASHSTATE=true # stashed state ($ stashed)
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM="auto" # HEAD vs upstream state (> ahead, < behind, <> diverged)

RESET="\[\033[0m\]"
BLACK="\[\033[0;30m\]"
BLUE="\[\033[0;34m\]"
CYAN="\[\033[0;36m\]"
GREEN="\[\033[0;32m\]"
PURPLE="\[\033[0;35m\]"
RED="\[\033[0;31m\]"
WHITE="\[\033[0;37m\]"
YELLOW="\[\033[0;33m\]"

PS1=
if [[ -n $SSH_CLIENT || -n $SSH_CONNECTION ]] ; then
  PS1=$PS1"${RED}\h:${RESET}:"
fi
PS1=$PS1"[${YELLOW}\w${RESET}] "
PS1=$PS1"\$(__git_ps1) "
PS1=$PS1"${BLUE}\u${RESET} "
PS1=$PS1"\$ "
