#!/bin/bash

# © Outsourcing IT - Konopnickiej.Com
# Author: Paweł Wojciechowski

command_exists () {
  type "$1" &> /dev/null ;
}

# Installation function. This is where magic happens.

function line {
  echo '#####################################################'
}

function install {

  echo
  line
  echo "Installing $1 ..."
  line
  echo

  case "$1" in

    ruby)

    echo "Installing Ruby $RUBY_VER via rbenv"
    echo 'With Ruby installation you have to install GNU Bash for Git'
    echo

    if command_exists rbenv ; then

      echo 'rbenv is already installed. Skipping this part...'

    else

      echo 'rbenv is not installed. Installing...'

      git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
      export PATH="$HOME/.rbenv/bin:$PATH"
      eval "$(rbenv init -)"
      git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
      export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
      git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash
    fi

    rbenv install "$RUBY_VER"
    rbenv global "$RUBY_VER"

    ;;

    bash4git)

    if command_exists git ; then
      echo 'Installing GNU Bash for Git'
      echo "Setting global Git configuration"
      echo

      GIT_NAME=$(git config --global user.name)
      GIT_EMAIL=$(git config --global user.email)

      if [ ! -z "$GIT_NAME" ] ; then
        echo "I've found Git global user.name: $GIT_NAME"
      fi

      if [ ! -z "$GIT_EMAIL" ] ; then
        echo "I've found Git global user.email: $GIT_EMAIL"
      fi

      while [ -z "$GIT_NAME" ] ; do
        echo "(user.name) Please provide your full name [ENTER]:"
        read GIT_NAME
      done

      while [ -z "$GIT_EMAIL" ] ; do
        echo "(user.email) Please provide your email [ENTER]:"
        read GIT_EMAIL
      done

      # Copying configuration files to ~/

      files=( '.gitconfig' '.bashrc' '.bash_aliases' )
      for file in "${files[@]}"
      do
        echo "Installing ~/$file"
        cp -f ~/"$file" ~/"$file".old
        cp -f "$file" ~/"$file"
      done

      echo 'Setting Git global user.name and user.email'
      git config --global user.name "$GIT_NAME"
      git config --global user.email "$GIT_EMAIL"

    else
      echo 'Git is not installed. Please install it'
    fi

    ;;

  esac

  echo
  line
  echo "Installation of $1 finished."
  line
  echo

}

# Function that build selectable menu. It has two options
# * txt - simple text menu
# * dialog - menu built using dialog command

function gui {
  case $1 in
    txt)
    echo
    line
    echo '© Outsourcing IT - Konopnickiej.Com'
    line
    echo
    line
    echo 'Welcome to our installer'
    line
    echo

    PROMPT="
    Pick an option to install:
    "

    options=(
    "* Colorful and useful GNU Bash for Git functionality *"
    "* Install Ruby $RUBY_VER via rbevn *"
    )

    PS3="$PROMPT"
    select opt in "${options[@]}" "Quit                                "; do

      case "$REPLY" in

        1 ) install bash4git ;;
        2 ) install ruby ;;

        $(( ${#options[@]}+1 )) ) echo "Goodbye!"; break;;

        *) echo "Invalid option: $opt - [$REPLY]. Try another one. "; continue;;

      esac

    done
    ;;

    dialog)
    cmd=(dialog --separate-output --checklist "Select options to install:" 22 76 16)
    options=(
      1 "Colorful and useful GNU Bash for Git functionality" on
      2 "Install Ruby $RUBY_VER via rbevn" on
    )
    choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)

    clear
    for choice in $choices
    do
      case $choice in
        1 ) install bash4git ;;
        2 ) install ruby ;;
      esac
    done
    ;;
  esac
}
