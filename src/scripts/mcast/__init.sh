#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Bash Wrapper around Multicast Publisher/Receiver

#----- globals

SCRIPT_DIR=${BSFPE_DIR}/scripts/mcast


#----- functions
mcast::pub() {
  python3 ${SCRIPT_DIR}/mcastpub.py $*
}

mcast::recv() {
  python3 ${SCRIPT_DIR}/mcastrcv.py $*
}
