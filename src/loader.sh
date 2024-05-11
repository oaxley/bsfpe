#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Main loader script

#----- globals

BSFPE_DIR=$(dirname ${BASH_SOURCE})


#----- functions
_pushd() {
  pushd $1 >/dev/null 2>&1
}

_popd() {
  popd >/dev/null 2>&1
}

#----- begin

# ensure we are in the loader directory
_pushd ${BSFPE_DIR}

# export our location for all the scripts
export BSFPE_DIR

# go through all the directories and load the functions
for DIR in */; do
  if [[ -e ${DIR}/__init.sh ]]; then
    _pushd ${DIR}
    source __init.sh
    _popd
  fi
done
_popd

# clean the environment
unset BSFPE_DIR
unset _pushd _popd