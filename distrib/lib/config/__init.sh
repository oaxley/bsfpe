#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Bash Wrapper around configuration parsers

#----- guards
# ensure python is available
PYTHON_BIN=$(which python3)
[[ -z ${PYTHON_BIN} || ! -x ${PYTHON_BIN} ]] && return 0


#----- functions
config::ini() {
  python3 "${BSFPE_LIBRARY_DIR}/scripts/config/iniparser.py" "$@"
}

config::yaml() {
  python3 "${BSFPE_LIBRARY_DIR}/scripts/config/yamlparser.py" "$@"
}

config::toml() {
  python3 "${BSFPE_LIBRARY_DIR}/scripts/config/tomlparser.py" "$@"
}
