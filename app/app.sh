#!/bin/bash

# © Outsourcing IT - Konopnickiej.Com
# Author: Paweł Wojciechowski

DESCRIPTION_OPTIONS_GIT="Git with Git Kurwa! option"
DESCRIPTION_OPTIONS_RUBY="Ruby $RUBY_VER via rbevn"
DESCRIPTION_OPTIONS_ROR="Ruby on Rails - latest version"
DESCRIPTION_OPTIONS_MYSQL="MySQL client and dev packages"

command_exists () {
  type "$1" &> /dev/null ;
}

function pre_checks {

  if command_exists apt-get ; then
    echo 'apt-get is available.'
  else
    echo 'apt-get is not available'
    return 0
  fi

  if command_exists sudo ; then
    echo "sudo is avaialble. Checking if we can use it:"
    sudo true
    if [ "$?" == 0 ] ; then
      echo 'sudo works. Performing package update.'
      #sudo apt-get update
      pause
    else
      echo "We don't have access to sudo."
      return 0
    fi
  else
    echo 'sudo is not avaialable'
    return 0
  fi

  return 1

}

function line {
  echo '#####################################################'
}

function display_author {
  echo
  echo '+-------------------------------------+'
  echo '| © Outsourcing IT - Konopnickiej.Com |'
  echo '| Author: Paweł Wojciechowski         |'
  echo '+-------------------------------------+'
  echo
}


# Installation function. This is where magic happens.

function install_option {

  echo
  line
  echo "Installing $1 ..."
  line
  echo

  case "$1" in

    ruby)

    echo "Installing Ruby $RUBY_VER via rbenv"
    echo

    echo 'Installing requiured packages:'
    sudo apt-get install curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev

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

    if command_exists gem ; then
      echo "gem: --no-ri --no-rdoc" > ~/.gemrc
      gem install bundler
    else
      echo "I'm not able to install bundle. gem is not available"
    fi

    ;;

    ruby_on_rails)
    # Ruby on Rails installation
    if command_exists gem ; then

      if [ -n "$RUBY_ON_RAILS_VER" ]; then

        echo "Installing Ruby on Rails from versions.sh file: $RUBY_ON_RAILS_VER"
        gem install rails -v "$RUBY_ON_RAILS_VER"

      else

        echo 'Installing latest, stable Ruby on Rails available.'
        gem install rails

      fi

      rbenv rehash

    else

      echo '*gem* is not available. Have you already installed Ruby?'

    fi

    ;;

    mysql)

    sudo apt-get install mysql-server mysql-client libmysqlclient-dev

    ;;

    git)
    # Git improvements installation.

    if command_exists git ; then

      echo 'Git is installed. Skipping installation'

    else

      sudo apt-get install git-core

    fi

    if command_exists git ; then

      echo
      echo 'Installing GNU Bash for Git'
      echo "Setting global Git configuration"

      echo
      GIT_NAME=$(git config --global user.name)
      GIT_EMAIL=$(git config --global user.email)
      echo

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
        cp -f "files/$file" ~/"$file"
      done

      echo 'Setting Git global user.name and user.email'
      git config --global user.name "$GIT_NAME"
      git config --global user.email "$GIT_EMAIL"

    else
      echo 'Git is not installed. Please check what happened'
    fi

    ;;

  esac

  echo
  echo "Installation of $1 finished."
  echo

}

# Function that builds selectable menu. It has two options
# * txt     - simple, plain text menu
# * dialog  - menu created with Dialog application (if available)

function gui {
  case $1 in
    txt)

    display_author

    line
    echo 'Welcome to our installer'
    line
    echo

    PROMPT="
    Pick an option to install [ENTER]:
    "

    options=(
    "$DESCRIPTION_OPTIONS_GIT"
    "$DESCRIPTION_OPTIONS_RUBY"
    "$DESCRIPTION_OPTIONS_ROR"
    "$DESCRIPTION_OPTIONS_MYSQL"
    )

    PS3="$PROMPT"

    select opt in "${options[@]}" "Quit"; do

      case "$REPLY" in

        1) install_option git ;;
        2) install_option ruby ;;
        3) install_option ruby_on_rails ;;
        4) install_option mysql ;;
        $(( ${#options[@]}+1 )) ) echo "Goodbye!"; break;;

        *) echo "Invalid option: [$REPLY]. Try another one. "; continue;;

      esac

    done
    ;;

    dialog)

    cmd=(dialog --separate-output --checklist "Select options to install:" 22 76 16)

    options=(
    1 "$DESCRIPTION_OPTIONS_GIT" on
    2 "$DESCRIPTION_OPTIONS_RUBY" on
    3 "$DESCRIPTION_OPTIONS_ROR" on
    4 "$DESCRIPTION_OPTIONS_MYSQL" on
    )

    choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)

    clear

    for choice in $choices
    do
      case $choice in

        1 ) install_option git ;;
        2 ) install_option ruby ;;
        3 ) install_option ruby_on_rails ;;
        4 ) install_option mysql ;;

      esac
    done

    ;;

  esac
}
