#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Main loader script

#----- globals
# export our location for all the scripts
# shellcheck disable=SC2128
__dir=$(dirname "${BASH_SOURCE}")
BSFPE_LIBRARY_DIR=$(realpath "${__dir}")
export BSFPE_LIBRARY_DIR


#----- functions
_pushd() {
  # shellcheck disable=SC2164
  pushd "$1" >/dev/null 2>&1
}

_popd() {
  # shellcheck disable=SC2164
  popd >/dev/null 2>&1
}


#----- begin
# ensure we are in the loader directory before loading functions
_pushd "${BSFPE_LIBRARY_DIR}/lib"

# shellcheck disable=SC1091
source __init.sh
_popd

# add manpages
export MANPATH="${BSFPE_LIBRARY_DIR}/man:${MANPATH}"

# clean the environment
unset _pushd _popd

