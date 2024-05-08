#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Network functions

#----- public functions

# create a TCP Listener to check FW ports
# arguments:
#   $1 : the TCP port
network::fake_server() {
  python3 -m http.server $1
}

# test if a host:port is opened
# arguments:
#   $1 : a string "host:port"
# return:
#   0 if the connection is successful, >0 otherwise
network::zero_connect() {
  local _hostname=$(echo $1 | cut -d: -f1)
  local _port=$(echo $1 | cut -d: -f2)
  nc -zv ${_hostname} ${_port}
}

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
