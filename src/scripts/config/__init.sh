#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Bash Wrapper around configuration parsers

#----- globals
SCRIPT_DIR=${BSFPE_DIR}/scripts/config


#----- functions
config::ini() {
  python3 ${SCRIPT_DIR}/iniparser.py $*
}

config::yaml() {
  python3 ${SCRIPT_DIR}/yamlparser.py $*
}

config::toml() {
  python3 ${SCRIPT_DIR}/tomlparser.py $*
}
