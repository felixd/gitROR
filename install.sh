#!/bin/bash

# © Outsourcing IT - Konopnickiej.Com
# Author: Paweł Wojciechowski
# Date: 28th Janury 2016
# Version: v1.2.0

source "versions.sh"
source "app/app.sh"

clear

# Select Menu type manually (using parameter) or let it be discovered automatically.
# $ ./install.sh txt      - Plain Text menu
# $ ./install.sh dialog   - GUI menu using Dialog application (if available)
# $ ./install.sh          - Automatically discovered

display_author

line
echo "Checking if we will be able to install stuff."
line

pre_checks
if [ "$?" == 0 ] ; then
  echo 'Pre checking failed. Exiting.'
  exit
fi

clear

case $1 in
  txt)
  # Menu created using plain text
  gui txt ;;

  dialog)
  # Menu created using 'dialog'
  gui dialog ;;

  *)
  # Automatic menu type is being discovered below.
  if command_exists dialog ; then
    gui dialog
  else
    gui txt
  fi
  ;;
esac
