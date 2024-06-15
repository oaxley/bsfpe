#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    CPU info (Linux specific)

#----- guards
# do not load if the file does not exist on the system
[[ ! -e /proc/cpuinfo ]] && return

#----- public functions
# return the CPU type
system::cpu_type() {
  grep 'model name' /proc/cpuinfo | tail -1 | cut -d: -f2
}

# return the CPU count
system::cpu_count() {
  grep -c 'processor' /proc/cpuinfo
}

# check is a CPU flag is present
# arguments:
#   $1 : the flag to check
# return:
#   0 if the flag is present, 1 otherwise
system::cpu_flag() {
  grep 'flags' /proc/cpuinfo | head -1 | xargs -n 1 | grep "^$1$" >/dev/null
  return $?
}
