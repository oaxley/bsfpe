#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT license
#
# @brief    Export all defined functions

#----- begin
for FILE in *.sh; do

  # prevent infinite loop
  [[ "${FILE}" == "__init.sh" ]] && continue

  # shellcheck disable=SC1090
  source "${FILE}"
done