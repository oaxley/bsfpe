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

#.--
#.1 Generate a UUIDv4 number
#.3H Generate a random UUIDv4 number.
#.4 Generate a UUID
#.4 $ uuid::uuid4     # output: 8b6f7afe-83a0-48a6-a8e1-846d85e06705
#.--
uuid::uuid4() {
  python3 -c 'import uuid; print(uuid.uuid4())'
}
