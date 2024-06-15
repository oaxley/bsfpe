#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Library init script

#----- begin
# go through all the directories
for DIR in */; do
  if [[ -e "${DIR}/__init.sh" ]]; then
    _pushd "${DIR}"
    # shellcheck disable=SC1091
    source __init.sh
    _popd
  fi
done
