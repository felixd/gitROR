#!/bin/bash

# © Outsourcing IT - Konopnickiej.Com
# Author: Paweł Wojciechowski
# Date: 28th Janury 2016
# Version: v1.0

source "versions.sh"
source "app/app.sh"

clear

# You can select manually which menu to select by providing parameter to # ./install.sh script.

case $1 in
  txt)
  gui txt
  ;;
  dialog)
  gui dialog
  ;;
  *)
  if command_exists dialog ; then
    gui dialog
  else
    gui txt
  fi
  ;;
esac
