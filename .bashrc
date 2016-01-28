# © Outsourcing IT - Konopnickiej.Com
# Author: Paweł Wojciechowski
# Date: 28th Janury 2016
# Version: v1.0

# Configure colors, if available.
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    c_reset='\[\e[0m\]'
    c_user='\[\033[1;31m\]'
    c_path='\[\e[0;34m\]'
    c_git_clean='\[\e[0;36m\]'
    c_git_dirty='\[\e[0;35m\]'
else
    c_reset=
    c_user=
    c_path=
    c_git_clean=
    c_git_dirty=
fi

# Function to assemble the Git part of our prompt.
git_prompt ()
{
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        return 0
    fi
 
    git_branch=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p') 
    echo " [$git_branch${c_reset}]"
}
 
# Thy holy prompt.
PROMPT_COMMAND='PS1="${c_user}\u${c_reset}@${c_user}\h${c_reset}:${c_path}\w${c_reset}$(git_prompt)\$ "'

# change working directory to root of repo
git-root() {
 cd "$(git proot)"
}

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Checking if rbenv (Ruby) is installed. If it's adding it to $PATH

if [ -d ~/.rbenv/ ]; then
 export PATH="$HOME/.rbenv/bin:$PATH"
 eval "$(rbenv init -)"
 export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
fi
