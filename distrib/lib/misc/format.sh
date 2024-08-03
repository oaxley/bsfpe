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
#.3H Format a value in Bytes to its closest representable value.
#.3F Returns True (0) if successful, False (1) otherwise
#.4 Convert this value to iec-i
#.4 $ format::size 576345     # output: 562.836 KiB
#.--
format::size() {
  numfmt --to=iec-i --suffix="B" --format="%.02f" "$1"
}
