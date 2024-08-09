#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    KVStore initialization file

# load all the files
for FILE in *.sh; do
  # prevent infinite loop
  [[ "${FILE}" == "__init.sh" ]] && continue

  # shellcheck disable=SC1090
  source "${FILE}"
done