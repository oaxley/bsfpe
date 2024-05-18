#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Remove a key from the store

#----- functions
# print help for the 'del' function
commands::del::help() {
  echo "kvstore.sh - Del command"
  echo "Syntax:"
  echo "    del <key>"
  echo "        remove the key from the store"
}

# main function
# arguments:
#   $1 : key
commands::del::main() {
  # print help
  if [[ "$1" == "--help" ]]; then
    commands::del::help
    return 0
  fi

  # retrieve values from the command line
  KEY=$1

  # key lookup
  STRING=$(cat ${CACHE_DIR}/${CACHE_FILE} | grep "^${KEY}:" | tail -1)
  if [[ -z "${STRING}" ]]; then
    logger::error "Cannot find the key '${KEY}' in the store"
    return 1
  fi

  VALUE="this key has been deleted"

  # retrieve the current time, and set the TTL in the past
  TIMESTAMP=$(date "+%s")
  TTL=$(( TIMESTAMP - 300 ))

  # add the key/value pair to the store
  echo "${KEY}:${TTL}:${VALUE}" >> ${CACHE_DIR}/${CACHE_FILE}

  logger::info "Key '${KEY}' has been removed from the store"
}