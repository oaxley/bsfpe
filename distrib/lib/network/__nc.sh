#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Network functions with netcat ('nc') as a backend

#----- guards
__bin=$(which nc)
[[ -z ${__bin} ]] && return


#----- public functions

# test if a host:port is opened
# arguments:
#   $1 : a string "host:port"
# return:
#   0 if the connection is successful, >0 otherwise
network::zero_connect() {
  # shellcheck disable=SC2155
  local _hostname=$(echo "$1" | cut -d: -f1)

  # shellcheck disable=SC2155
  local _port=$(echo "$1" | cut -d: -f2)

  nc -zv "${_hostname}" "${_port}"
}

