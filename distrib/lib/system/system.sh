#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    OS/System generic functions

#----- public functions

# compare if two files are identicals
# arguments:
#   $1 : the path to the first file
#   $2 : the path to the second file
# returns:
#   0 if both files are identical, 1 otherwise
system::file_compare() {
  # build the sha1 from the files
  # shellcheck disable=SC2155
  local __sha1_right=$(sha1sum "$1" | awk '{print $1}')

  # shellcheck disable=SC2155
  local __sha1_left=$(sha1sum "$2" | awk '{print $1}')

  [[ "${__sha1_right}" == "${__sha1_left}" ]] && return 0
  return 1
}