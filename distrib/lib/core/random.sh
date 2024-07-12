#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Random number generator functions

#----- private functions

# generate a random value
# arguments:
#   $1 : the number of Bytes (8,16,24,32) for the number
# return:
#   the hexadecimal value from /dev/urandom
random::_rand() {
  dd if=/dev/urandom count="$1" bs=1 2>/dev/null | xxd -p
}


#----- public functions
#.--
#.1 Generate a 8-bits random value
#.3H Generate a 8-bits value between 0 and 255. !!
#.3F The value is generated with the /dev/urandom device.
#.--
random::rand8() {
  echo $((16#$(random::_rand 1)))
}

#.--
#.1 Generate a 16-bits random value
#.3H Generate a 16-bits value between 0 and 65,525. !!
#.3F The value is generated with the /dev/urandom device.
#.--
random::rand16() {
  echo $((16#$(random::_rand 2)))
}

#.--
#.1 Generate a 24-bits random value
#.3H Generate a 24-bits value between 0 and 16,777,215. !!
#.3F The value is generated with the /dev/urandom device.
#.--
random::rand24() {
  echo $((16#$(random::_rand 3)))
}

#.--
#.1 Generate a 24-bits random value
#.3H Generate a 24-bits value between 0 and 4,294,967,295. !!
#.3F The value is generated with the /dev/urandom device.
#.--
random::rand32() {
  echo $((16#$(random::_rand 4)))
}

