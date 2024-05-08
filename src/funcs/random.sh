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
  echo $(dd if=/dev/urandom count=$1 bs=1 2>/dev/null | xxd -p)
}


#----- public functions
# generate a 8-bits random value
# return:
#   a value between 0 and 255
random::rand8() {
  echo $((16#$(random::_rand 1)))
}

# generate a 16-bits random value
# return:
#   a value between 0 and 65,535
random::rand16() {
  echo $((16#$(random::_rand 2)))
}

# generate a 24-bits random value
# return:
#   a value between 0 and 16,777,215
random::rand24() {
  echo $((16#$(random::_rand 3)))
}

# generate a 32-bits random value
# return:
#   a value between 0 and 4,294,967,295
random::rand32() {
  echo $((16#$(random::_rand 4)))
}

