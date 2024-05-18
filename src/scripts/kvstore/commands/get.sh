#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Get a Value associated with a Key

#----- functions
# print help for the 'get' function
commands::get::help() {
  echo "kvstore.sh - Get command"
  echo "Syntax:"
  echo "    get <key>"
  echo "        return the value associated with this key"
}

# main function
# arguments:
#   $1 : key
commands::get::main() {
  # print help
  if [[ "$1" == "--help" ]]; then
    commands::get::help
    return
  fi

  # retrieve values from the command line and
  # look for the latest occurence of this key
  KEY=$1
  STRING=$(cat ${CACHE_DIR}/${CACHE_FILE} | grep "^${KEY}:" | tail -1)

  # nothing found
  if [[ -z "${STRING}" ]]; then
    logger::error "The key cannot be found"
    return 1
  fi

  # split the data in parts
  TTL=$(echo $STRING | cut -d: -f2)
  VALUE=$(echo $STRING | cut -d: -f3)

  # nothing to do with TTL == 0
  if (( TTL > 0 )); then
    # retrieve the current time and compare it with the TTL
    TIMESTAMP=$(date "+%s")
    if (( TIMESTAMP > TTL )); then
      logger::warning "The key has expired"
      return 1
    fi
  fi

  echo "${VALUE}" | base64 -d
}