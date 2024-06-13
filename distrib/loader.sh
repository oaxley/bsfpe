#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Main loader script

set -uo pipefail

#----- globals
# export our location for all the scripts
# shellcheck disable=SC2128
BSFPE_LIBRARY_DIR=$(dirname "${BASH_SOURCE}")
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

# ensure we are in the loader directory
_pushd "${BSFPE_LIBRARY_DIR}"

# go through all the directories and load the functions
for DIR in */; do
  if [[ -e ${DIR}/__init.sh ]]; then
    # shellcheck disable=SC2164
    _pushd "${DIR}"

    # shellcheck disable=SC1091
    source __init.sh

    _popd
  fi
done
_popd

# clean the environment
unset _pushd _popd