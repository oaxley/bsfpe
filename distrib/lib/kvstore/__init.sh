#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Bash Wrapper around the KVStore scripts

#----- functions
kvstore::main() {
  # shellcheck disable=SC1091
  . "${BSFPE_LIBRARY_DIR}/lib/kvstore/kvstore.sh" "$@"
}

kvstore::set() {
  # shellcheck disable=SC1091
  . "${BSFPE_LIBRARY_DIR}/lib/kvstore/kvstore.sh" set "$@"
}

kvstore::get() {
  # shellcheck disable=SC1091
  . "${BSFPE_LIBRARY_DIR}/lib/kvstore/kvstore.sh" get "$@"
}

kvstore::del() {
  # shellcheck disable=SC1091
  . "${BSFPE_LIBRARY_DIR}/lib/kvstore/kvstore.sh" del "$@"
}

kvstore::clean() {
  # shellcheck disable=SC1091
  . "${BSFPE_LIBRARY_DIR}/lib/kvstore/kvstore.sh" clean "$@"
}

kvstore::print() {
  # shellcheck disable=SC1091
  . "${BSFPE_LIBRARY_DIR}/lib/kvstore/kvstore.sh" print "$@"
}
