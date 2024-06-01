#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Bash Wrapper around Multicast Publisher/Receiver

#----- guards
# ensure python is available
PYTHON_BIN=$(which python3)
[[ -z ${PYTHON_BIN} || ! -x ${PYTHON_BIN} ]] && return 0

#----- functions
mcast::pub() {
  python3 ${BSFPE_LIBRARY_DIR}/scripts/mcast/mcastpub.py $*
}

mcast::recv() {
  python3 ${BSFPE_LIBRARY_DIR}/scripts/mcast/mcastrcv.py $*
}
