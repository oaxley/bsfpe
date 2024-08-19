#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Basic statistical maths functions

#----- globals
__values=()

#----- functions

#.--
#.1 Add value to the array
#.2 (value1, value2, ...){The values to insert into the array.}
#.4 Add 3 values to the array
#.4 maths::append 10 20 30
#.--
maths::append() {
  __values+=("$@")
}

#.--
#.1 Clear the whole array
#.--
maths::clear() {
  __values=()
}

#.--
#.1 Returns the length of the array
#.--
maths::length() {
  echo ${#__values[@]}
}

