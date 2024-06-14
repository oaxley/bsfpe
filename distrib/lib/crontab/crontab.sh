#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Aliases for crontab management

#----- globals
CRONTAB_BIN=$(which crontab)


#----- functions

# we redefine a function crontab to ensure we cannot remove a crontab from production
crontab() {
  case "$1" in
    "-r")
      echo "Error: deletion of crontab is not authorized"
      ;;
    *)
      command ${CRONTAB_BIN} "$@"
      ;;
  esac
}
