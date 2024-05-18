#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Set a Key/Value pair in the store

#----- functions
# print help for the 'set' function
commands::set::help() {
  echo "kvstore.sh - Set command"
  echo "Syntax:"
  echo "    set <key> <value>"
  echo "        insert a new key/value pair in the store"
  echo "    set <key> <@ttl>"
  echo "        set the TTL (in seconds) for this key"
}

# main function
# arguments:
#   $1 : key
#   $2 : value
commands::set::main() {
  # print help
  if [[ "$1" == "--help" ]]; then
    commands::set::help
    return
  fi

  # retrieve values from the command line
  KEY=$1
  shift

  # retrieve the value
  VALUE="$*"

  # check if we set a value or a TTL
  MARKER=$(echo "${VALUE}" | cut -c1)
  if [[ "${MARKER}" == "@" ]]; then
    # retrieve the last occurence of the key
    VALUE_B64=$(grep "^${KEY}:" ${CACHE_DIR}/${CACHE_FILE} | tail -1 | cut -d: -f3)

    # compute the new TTL
    TIMESTAMP=$(date "+%s")
    TTL=$(echo "${VALUE}" | cut -c2-)
    TTL=$(( TIMESTAMP + TTL ))
  else
    # encode the value as base64
    VALUE_B64=$(echo "${VALUE}" | base64 -w0)
    TTL=0
  fi

  # add a new entry to the store
  echo "${KEY}:${TTL}:${VALUE_B64}" >> ${CACHE_DIR}/${CACHE_FILE}

  logger::info "Key '${KEY}' has been added to the store with a TTL of '${TTL}'"
}