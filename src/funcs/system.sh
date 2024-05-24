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
  local __sha1_right=$(sha1sum $1 | awk '{print $1}')
  local __sha1_left=$(sha1sum $2 | awk '{print $1}')

  [[ "${__sha1_right}" == "${__sha1_left}" ]] && return 0
  return 1
}

# create a patch
# arguments:
#   $1 : initial file
#   $2 : new file
#   $3 : patch name
system::patch_create() {
  diff -u $1 $2 > $3
}

# apply a patch to a file
# arguments:
#   $1 : initial file
#   $2 : patch file
system::patch_apply() {
  patch -p1 $1 < $2
}

# revert a patch applied to a file
# arguments:
#   $1 : initial file
#   $2 : patch file
system::patch_revert() {
  patch -R -p1 $1 < $2
}

# return the CPU type
system::cpu_type() {
  grep 'model name' /proc/cpuinfo | tail -1 | cut -d: -f2
}

# return the CPU count
system::cpu_count() {
  grep 'processor' /proc/cpuinfo | wc -l
}

# check is a CPU flag is present
# arguments:
#   $1 : the flag to check
# return:
#   0 if the flag is present, 1 otherwise
system::cpu_flag() {
  grep 'flags' /proc/cpuinfo | head -1 | xargs -n 1 | grep "^$1$" >/dev/null
  return $?
}