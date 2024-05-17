#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Bash Wrapper around configuration parsers

#----- functions
config::ini() {
  python3 ${BSFPE_LIBRARY_DIR}/scripts/config/iniparser.py $*
}

config::yaml() {
  python3 ${BSFPE_LIBRARY_DIR}/scripts/config/yamlparser.py $*
}

config::toml() {
  python3 ${BSFPE_LIBRARY_DIR}/scripts/config/tomlparser.py $*
}
