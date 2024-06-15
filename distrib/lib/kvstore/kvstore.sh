#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Key/Value Store for shell scripts

#----- globals
# shellcheck disable=SC2128
SCRIPT_NAME=$(basename "${BASH_SOURCE}")
SCRIPT_DIR=$(dirname "${BASH_SOURCE}")
if [[ "${SCRIPT_DIR}" == "." ]]; then
  SCRIPT_DIR=$(pwd)
fi

if [[ -z ${XDG_CACHE_DIR} ]]; then
  CACHE_DIR=${SCRIPT_DIR}/.cache
else
  CACHE_DIR=${XDG_CACHE_DIR}
fi

# shellcheck disable=SC2034
CACHE_FILE=${SCRIPT_NAME%.sh}

#----- imports
# shellcheck disable=SC1091
source "${SCRIPT_DIR}/../core/logger.sh"

#----- functions
help() {
  echo "${SCRIPT_NAME} - Key/Value store for shell scripts"
  echo "Syntax:"
  echo "    ${SCRIPT_NAME} <command> <arguments|--help>"
  echo ""
  echo "command:"
  echo "    set   : add a new key/value to the store"
  echo "    get   : retrieve a value associated with the key"
  echo "    del   : remove a key from the store"
  echo "    clean : remove expired keys from the store"
  exit 0
}


#----- begin
# create the cache directory
mkdir -p "${CACHE_DIR}"

if (( $# == 0 )); then
  help
fi

# parse the command line
case "$1" in
  "-h"|"--help")
    help
    ;;
  "set")
    shift
    # shellcheck disable=SC1091
    source "${SCRIPT_DIR}/commands/set.sh"
    commands::set::main "$@"
    ;;
  "get")
    shift
    # shellcheck disable=SC1091
    source "${SCRIPT_DIR}/commands/get.sh"
    commands::get::main "$@"
    ;;
  "del")
    shift
    # shellcheck disable=SC1091
    source "${SCRIPT_DIR}/commands/del.sh"
    commands::del::main "$@"
    ;;
  "clean")
    shift
    # shellcheck disable=SC1091
    source "${SCRIPT_DIR}/commands/clean.sh"
    commands::clean::main "$@"
    ;;
  "print")
    shift
    # shellcheck disable=SC1091
    source "${SCRIPT_DIR}/commands/print.sh"
    commands::print::main "$@"
    ;;
esac