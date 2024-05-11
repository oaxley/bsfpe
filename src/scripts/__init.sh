#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Load all the wrapper scripts

#----- begin

for DIR in */; do
  if [[ -e ${DIR}/__init.sh ]]; then
    _pushd ${DIR}
    source __init.sh
    _popd
  fi
done
