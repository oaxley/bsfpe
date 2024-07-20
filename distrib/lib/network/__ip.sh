#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Network functions with ip as a backend

#----- guards
__bin=$(which ip)
[[ -z ${__bin} ]] && return


#----- public functions

#.--
#.1 Retrieve the MAC address
#.2 (iface){Ethernet network interface.}
#.3H Retrieve the current MAC address of the Ethernet interface
#.4 Get the MAC address of eth0
#.4 $ network::mac_address eth0
#.--
network::mac_address() {
  ip link show "$1" | grep ether | awk '{print $2}'
}

#.--
#.1 Retrieve the IP address
#.2 (iface){Ethernet network interface.}
#.3H Retrieve the current IP address of the Ethernet interface
#.3F On Linux, the IP address will include the mask (for ex. 172.17.0.2/16)
#.4 Get the IP address of eth0
#.4 $ network::ip_address eth0
#.--
network::ip_address() {
  ip address show dev "$1" | grep inet | awk '{print $2}'
}

