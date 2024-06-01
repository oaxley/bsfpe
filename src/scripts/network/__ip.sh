#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Network functions with ip as a backend

#----- guards
__bin=$(which ip)
[[ -z ${__bin} || ! -x ${__bin} ]] && return


#----- public functions

# retrieve the MAC address of an interface
# arguments:
#   $1 : the interface
# return:
#   the mac address of this interface
network::mac_address() {
  ip link show $1 | grep ether | awk '{print $2}'
}

# retrieve the IP address of an interface
# arguments:
#   $1 : the interface
# return:
#   the IP address of this interface
network::ip_address() {
  ip address show dev $1 | grep inet | awk '{print $2}'
}

