#
# .profile
#

. ~/.profile

#
# set prompt
#

case ${UID} in
0)
    PROMPT="%B%~#%b "
    PROMPT2="%B%_#%b "
    SPROMPT="%B%r is correct? [n,y,a,e]:%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%M ${PROMPT}"
    ;;
*)
    PROMPT="%~%% "
    PROMPT2="%_%% "
    SPROMPT="%r is correct? [n,y,a,e]: "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%M ${PROMPT}"
    ;;
esac

# auto change directory
#
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd

# command correct edition before each completion attempt
#
setopt correct

# compacked complete list display
#
setopt list_packed

# no remove postfix slash of command line
#
setopt noautoremoveslash

# no beep sound when complete list displayed
#
setopt nolistbeep


## Keybind configuration
#
# emacs like keybind (e.x. Ctrl-a goes to head of a line and Ctrl-e goes 
#   to end of it)
#
bindkey -e

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

## Command history configuration
#
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

## Completion configuration
#
fpath=(~/.zsh/functions/Completion ${fpath})
autoload -U compinit
compinit

## zsh editor
#
autoload vim

## Alias configuration
#
# expand aliases before completing
#
setopt complete_aliases     # aliased ls needs if file/dir completions work

alias where="command -v"
alias j="jobs -l"

case "${OSTYPE}" in
freebsd*)
    # ls
    alias ls="ls -G -w"
    ;;
darwin*)
    alias ls="ls -G -w"
    alias emacs="emacs -nw"
    alias vim="vi"
    ;;
linux*)
    alias ls="ls --color"
    ;;
esac

# keychain
keychain ~/.ssh/id_rsa
source ~/.keychain/${HOST}-sh

# sbcl
export SBCL_HOME=~/opt/sbcl/