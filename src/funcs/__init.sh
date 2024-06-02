#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT license
#
# @brief    Export all defined functions

#----- begin

# loop over all the BASH scripts defined in the directory
for script in *.sh; do

  # don't loop over ourself
  if [[ "${script}" == "__init.sh" ]]; then
    continue
  fi
  # shellcheck disable=SC1090
  source "${script}"
done
