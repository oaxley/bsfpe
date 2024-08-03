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
  ip address show "$1" | awk '($0 ~ /ether/) {print $2}'
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
  ip address show "$1" | awk '($0 ~ /inet/) {print $2}'
}

#.--
#.1 Retrieve the hostid
#.3H Retrieve the hostid of the machine
#.--
network::hostid() {
  hostid
}

#.--
#.1 Retrieve the full FQDN
#.3H Retrieve the Full Qualified Domain Name (FQDN) of the machine.
#.--
network::fqdn() {
  hostname -df
}

#.--
#.1 Retrieve the short hostname
#.3H Retrieve the short hostname of the machine.
#.--
network::hostname() {
  hostname -ds
}
