#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Network functions with python as a backend

#----- guards
# ensure python is available
__bin=$(which python3)
[[ -z ${__bin} ]] && return 0

#----- functions
# multicast publisher
network::mcast_pub() {
  python3 "${BSFPE_LIBRARY_DIR}/scripts/mcast/mcastpub.py" "$@"
}

# multicast receiver
network::mcast_recv() {
  python3 "${BSFPE_LIBRARY_DIR}/scripts/mcast/mcastrcv.py" "$@"
}

# create a TCP Listener to check FW ports
# arguments:
#   $1 : the TCP port
network::fake_server() {
  python3 -m http.server "$1"
}

