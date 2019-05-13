#
# ~/.zshrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

export EDITOR=nvim
export VISUAL=nvim
export SUDO_EDITOR=nvim

export http_proxy=127.0.0.1:8118
export https_proxy=127.0.0.1:8118
export HTTP_PROXY=127.0.0.1:8118
export HTTPS_PROXY=127.0.0.1:8118

export PATH=$PATH:/home/daquexian/.local/bin

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
    z
    )

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

bindkey -v
bindkey '^f' autosuggest-accept
bindkey '^j' autosuggest-execute
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line
bindkey '^[[Z' reverse-menu-complete
bindkey "^?" backward-delete-char

export XMODIFIERS=@im=fcitx
export QT_IM_MODULE=fcitx
export GTK_IM_MODULE=fcitx
export TERMINAL=termite

alias cmake-android-21-v7='cmake -DCMAKE_TOOLCHAIN_FILE=~/Android/Sdk/ndk-bundle/build/cmake/android.toolchain.cmake -DANDROID_PLATFORM=android-21 -DANDROID_ABI=armeabi-v7a -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE=Release'
alias cmake-android-28='cmake -DCMAKE_TOOLCHAIN_FILE=~/Android/Sdk/ndk-bundle/build/cmake/android.toolchain.cmake -DANDROID_PLATFORM=android-28 -DANDROID_ABI=arm64-v8a -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE=Release'
alias cmake-android-27='cmake -DCMAKE_TOOLCHAIN_FILE=~/Android/Sdk/ndk-bundle/build/cmake/android.toolchain.cmake -DANDROID_PLATFORM=android-27 -DANDROID_ABI=arm64-v8a -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE=Release'
fzfp(){
    fzf --preview '[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (highlight -O ansi -l {} || coderay {} || rougify {} || cat {}) 2> /dev/null | head -500'
}
fh(){
    print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *\**//')
}
alias vim=nvim
alias cat=bat

# Map caps lock to control
setxkbmap -option ctrl:nocaps
# Map single control to escape
xcape -e 'Control_L=Escape'
