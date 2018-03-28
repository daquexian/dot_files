#
# ~/.zshrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

export EDITOR=vim
export VISUAL=vim
export SUDO_EDITOR=vim

export http_proxy=127.0.0.1:8118
export https_proxy=127.0.0.1:8118
export HTTP_PROXY=127.0.0.1:8118
export HTTPS_PROXY=127.0.0.1:8118

export PATH=$PATH:/home/daquexian/.local/bin

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=1000
unsetopt beep
# End of lines configured by zsh-newuser-install
zstyle :compinstall filename '/home/daquexian/.zshrc'

autoload -Uz compinit promptinit
compinit
promptinit
prompt walters

export ZSH=/usr/share/oh-my-zsh

ZSH_THEME="jreese"
source $ZSH/oh-my-zsh.sh

plugins=(
    git
    archlinux
    history
    pip
    python
    vi-mode
    )

. /home/daquexian/repos/z/z.sh

bindkey -v
bindkey '^f' autosuggest-accept
bindkey '^j' autosuggest-execute
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line
