#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Generate UUID numbers

#----- guards
__bin=$(which python3)
[[ -z ${__bin} ]] && return


#----- public functions

# generate a UUID v4 number
# return:
#   a UUID v4 string
uuid::uuid4() {
  python3 -c 'import uuid; print(uuid.uuid4())'
}
