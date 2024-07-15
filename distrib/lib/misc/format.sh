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
#.--
#.1 Format a size value to human readable
#.2 (value){the value in Bytes}
#.3H Format a value in Bytes to its closest representable value. !!
#.3F Supported values are:
#.3F .br
#.3F - \fBBytes\fR (B)!!
#.3F - \fBKiloBytes\fR (KiB) !!
#.3F - \fBMegaBytes\fR (MiB) !!
#.3F - \fBGigaBytes\fR (GiB) !!
#.3F - \fBTeraBytes\fR (TiB)!!
#.4 Convert this size
#.4 $ format::size 576345     # output: 562.836 KiB
#.--
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
