# © Outsourcing IT - Konopnickiej.Com
# Author: Paweł Wojciechowski
# Date: 28th Janury 2016
# Version: v1.0

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -alCF'
alias la='ls -A'
alias l='ls -alF'

command_exists () {
    type "$1" &> /dev/null ;
}
