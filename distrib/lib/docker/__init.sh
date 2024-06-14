#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT license
#
# @brief    Export all defined functions

#----- begin

# ensure all the binaries are present before loading
__bin=$(which docker)
[[ -z ${__bin} ]] && return

__bin=$(which jq)
[[ -z ${__bin} ]] && return

# load all the files
for FILE in *.sh; do
  # prevent infinite loop
  [[ "${FILE}" == "__init.sh" ]] && continue

  # shellcheck disable=SC1090
  source "${FILE}"
done