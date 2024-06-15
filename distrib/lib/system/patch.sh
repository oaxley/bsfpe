#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    System patch

#----- public functions
# create a patch
# arguments:
#   $1 : initial file
#   $2 : new file
#   $3 : patch name
system::patch_create() {
  diff -u "$1" "$2" > "$3"
}

# apply a patch to a file
# arguments:
#   $1 : initial file
#   $2 : patch file
system::patch_apply() {
  patch -p1 "$1" < "$2"
}

# revert a patch applied to a file
# arguments:
#   $1 : initial file
#   $2 : patch file
system::patch_revert() {
  patch -R -p1 "$1" < "$2"
}

