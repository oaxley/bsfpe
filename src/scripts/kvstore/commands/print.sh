#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Print all the still valid keys

#----- functions
# print help for the 'del' function
commands::print::help() {
  echo "kvstore.sh - Print command"
  echo "Syntax:"
  echo "    print"
  echo "        print all the valid keys"
}

# main function
commands::print::main() {
  # print help
  if [[ "$1" == "--help" ]]; then
    commands::print::help
    return
  fi

  # go through all the key in the store
  declare -A elements
  while read STRING; do
    # retrieve the Key from the string
    # and add it to the associative array
    KEY=$(echo "${STRING}" | cut -d: -f1)
    elements[${KEY}]="${STRING}"
  done < ${CACHE_DIR}/${CACHE_FILE}

  # go through the array
  TIMESTAMP=$(date "+%s")
  for key in ${!elements[@]}; do
    STRING=${elements[$key]}
    TTL=$(echo "${STRING}" | cut -d: -f2)

    if (( TTL == 0 )); then
      echo "${key}"
    else
      if (( TIMESTAMP < TTL )); then
        echo "${key} @${TTL}"
      fi
    fi

  done
}