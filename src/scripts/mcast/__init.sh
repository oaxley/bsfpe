#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Bash Wrapper around Multicast Publisher/Receiver

#----- functions
mcast::pub() {
  python3 ${BSFPE_LIBRARY_DIR}/scripts/mcast/mcastpub.py $*
}

mcast::recv() {
  python3 ${BSFPE_LIBRARY_DIR}/scripts/mcast/mcastrcv.py $*
}
