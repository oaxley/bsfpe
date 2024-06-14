#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Bash Wrapper around configuration parsers

#----- guards
# ensure python is available
__bin=$(which python3)
[[ -z "${__bin}" ]] && return


#----- functions
config::ini() {
  python3 "${BSFPE_LIBRARY_DIR}/lib/config/iniparser.py" "$@"
}

config::yaml() {
  python3 "${BSFPE_LIBRARY_DIR}/lib/config/yamlparser.py" "$@"
}

config::toml() {
  python3 "${BSFPE_LIBRARY_DIR}/lib/config/tomlparser.py" "$@"
}
