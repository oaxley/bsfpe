#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Functions to format numbers

#----- guards
__bin=$(which bc)
[[ -z ${__bin} ]] && return


#----- public functions

# format a size in Bytes to the minimum representable unit
# arguments:
#   $1 : the size in Bytes
# return:
#   a string representing the size with the unit
format::size() {
  local __value=$1
  local __units=("B" "KiB" "MiB" "GiB" "TiB")
  local __unit=0

  # bash supports only integer
  local __int_value=${__value/.*/}
  while (( __int_value >= 1024 )); do
    __unit=$(( __unit + 1 ))
    __value=$(bc <<< "scale=3; ${__value} / 1024")
    __int_value=${__value/.*/}
  done

  printf "%.003f %s\n" "${__value}" "${__units[${__unit}]}"
}
