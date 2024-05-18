#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Clean the store from expired keys

#----- functions
# print help for the 'del' function
commands::clean::help() {
  echo "kvstore.sh - Clean command"
  echo "Syntax:"
  echo "    clean"
}

# main function
commands::clean::main() {
  # print help
  if [[ "$1" == "--help" ]]; then
    commands::clean::help
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

  # go through the array and create temporary cache file
  TMP_FILE=${CACHE_DIR}/${CACHE_FILE}.$$
  TIMESTAMP=$(date "+%s")
  for key in ${!elements[@]}; do
    STRING=${elements[$key]}
    TTL=$(echo "${STRING}" | cut -d: -f2)
    if (( TTL == 0 )); then
      echo "${STRING}" >> ${TMP_FILE}
    else
      if (( TIMESTAMP < TTL )); then
        echo "${STRING}" >> ${TMP_FILE}
      fi
    fi
  done

  # remove old cache
  mv -f ${TMP_FILE} ${CACHE_DIR}/${CACHE_FILE}
}