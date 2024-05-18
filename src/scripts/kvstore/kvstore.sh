#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Key/Value Store for shell scripts

#----- globals
SCRIPT_NAME=$(basename ${BASH_SOURCE})
SCRIPT_DIR=$(dirname ${BASH_SOURCE})
if [[ "${SCRIPT_DIR}" == "." ]]; then
  SCRIPT_DIR=$(pwd)
fi

CACHE_DIR=${SCRIPT_DIR}/.cache
CACHE_FILE=${SCRIPT_NAME%.sh}

#----- imports
source ${SCRIPT_DIR}/../../funcs/logger.sh

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
  exit
}


#----- begin
# create the cache directory
mkdir -p ${CACHE_DIR}

# parse the command line
case "$1" in
  "-h"|"--help")
    help
    ;;
  "set")
    shift
    source ${SCRIPT_DIR}/commands/set.sh
    commands::set::main $*
    ;;
  "get")
    shift
    source ${SCRIPT_DIR}/commands/get.sh
    commands::get::main $*
    ;;
  "del")
    shift
    source ${SCRIPT_DIR}/commands/del.sh
    commands::del::main $*
    ;;
  "clean")
    shift
    source ${SCRIPT_DIR}/commands/clean.sh
    commands::clean::main $*
    ;;
esac