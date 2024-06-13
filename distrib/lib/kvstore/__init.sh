#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Bash Wrapper around the KVStore scripts

#----- functions
kvstore::main() {
  . "${BSFPE_LIBRARY_DIR}/scripts/kvstore/kvstore.sh" "$@"
}

kvstore::set() {
  . "${BSFPE_LIBRARY_DIR}/scripts/kvstore/kvstore.sh" set "$@"
}

kvstore::get() {
  . "${BSFPE_LIBRARY_DIR}/scripts/kvstore/kvstore.sh" get "$@"
}

kvstore::del() {
  . "${BSFPE_LIBRARY_DIR}/scripts/kvstore/kvstore.sh" del "$@"
}

kvstore::clean() {
  . "${BSFPE_LIBRARY_DIR}/scripts/kvstore/kvstore.sh" clean "$@"
}

kvstore::print() {
  . "${BSFPE_LIBRARY_DIR}/scripts/kvstore/kvstore.sh" print "$@"
}
