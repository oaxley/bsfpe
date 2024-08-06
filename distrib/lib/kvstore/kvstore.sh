#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Key/Value store for shell scripts

#----- globals

# retrieve the script name and location
SCRIPT_NAME=$(basename "$0")
SCRIPT_DIR=$(dirname "$0")
if [[ "${SCRIPT_DIR}" == "." ]]; then
  SCRIPT_DIR=$(pwd)
fi

# store location
if [[ -z ${XDG_CONFIG_DIR} ]]; then
  STORE_PATH=${HOME}/.kvstore
else
  [[ ! -d ${XDG_CONFIG_DIR} ]] && mkdir -p "${XDG_CONFIG_DIR}/user"
  STORE_PATH="${XDG_CONFIG_DIR}/user/kvstore"
fi


#----- functions

kvstore::set() {
  :
}

kvstore::get() {
  :
}

kvstore::del() {
  :
}

kvstore::clean() {
  :
}

kvstore::print() {
  :
}

kvstore::is_exist() {
  :
}







