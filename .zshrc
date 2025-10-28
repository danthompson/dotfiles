# Multiple Homebrews on Apple Silicon
if [ "$(arch)" = "arm64" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/usr/local/bin/brew shellenv)"
fi

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

autoload -Uz compinit
compinit

if [ -f /opt/homebrew/etc/bash_completion.d/git-prompt.sh ]; then
    source /opt/homebrew/etc/bash_completion.d/git-prompt.sh
fi

function () {
    GIT_PS1_DESCRIBE_STYLE=branch # detached-head description
    GIT_PS1_SHOWCOLORHINTS=true # colors (only PROMPT_COMMAND)
    GIT_PS1_SHOWDIRTYSTATE=true # working directory state (* modified/+ staged)
    GIT_PS1_SHOWSTASHSTATE=true # stashed state ($ stashed)
    GIT_PS1_SHOWUNTRACKEDFILES=true
    GIT_PS1_SHOWUPSTREAM="auto" # HEAD vs upstream state (> ahead, < behind, <> diverged)

    PS1=
    if [[ -n $SSH_CLIENT || -n $SSH_CONNECTION ]] ; then
      PS1=$PS1"%F{red}%m:%f:"
    fi
    PS1=$PS1"[%F{yellow}%3~%f]"
    PS1=$PS1"\$(__git_ps1) "
    PS1=$PS1"%F{blue}%n%f "
    PS1=$PS1"\$ "

    setopt PROMPT_SUBST
}

# autoload -Uz vcs_info
# precmd() { vcs_info }
# zstyle ':vcs_info:git:*' formats '%b '
# setopt PROMPT_SUBST
# PROMPT='%F{green}%*%f %F{blue}%~%f %F{red}${vcs_info_msg_0_}%f$ '

setopt EXTENDED_GLOB
setopt NO_CASE_GLOB
setopt NUMERIC_GLOB_SORT
setopt AUTO_CD

HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
HISTSIZE=20000
SAVEHIST=20000

setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

setopt PROMPT_SUBST

# case insensitive path-completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# show descriptions when autocompleting
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' format 'Completing %d'

# partial completion suggestions
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' expand prefix suffix

# list with colors
zstyle ':completion:*' list-colors ''x

autoload -U colors && colors
export PATH=$PATH:$HOME/.dotnet/tools # dotnet-cli-tools
export PATH=$HOME/.local/bin:$PATH
export PATH=$PATH:$HOME/.cargo/bin # rust cargo
export PATH="$HOME/bin:$PATH" # me

export CLICOLOR=1
export TERM=xterm-256color
export EDITOR='nvim'
export GREP_COLOR='3;33'
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
export LESS='--ignore-case --raw-control-chars'
export MANPAGER='less -X'
export PAGER='less'
export FZF_DEFAULT_COMMAND='rg --files --ignore --hidden --follow --glob "!{.keep,.bundle,.git,.yarn,node_modules,temp,vendor/bundle}/*" --glob "!{*.meta,*.asset}"'
export FZF_DEFAULT_OPTS='--no-height --ansi'



eval "$(nodenv init -)"
eval "$(rbenv init -)"

if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
fi

[[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null

source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

if type nvim > /dev/null 2>&1; then
  alias vim="nvim"
fi

alias cpap='pwd | pbcopy && echo "Copied to clipboard"'
alias cprp='pwd | sed "s|$HOME/||" | pbcopy && echo "Copied relative path to clipboard"'

alias tmn='tmux new -s'
alias tma='tmux attach -t'
