#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT license
#
# @brief    Export all defined functions

#----- begin

# load only if we are in interactive mode
if [[ $- == *i* ]]; then

  # ensure crontab is defined before loading
  __bin=$(which crontab)
  [[ -z "${__bin}" ]] && return

  # loop over all the BASH scripts defined in the directory
  for script in *.sh; do

    # don't loop over ourself
    if [[ "${script}" == "__init.sh" ]]; then
      continue
    fi

    # shellcheck disable=SC1090
    source "${script}"
  done

fi
