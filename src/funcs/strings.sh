#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Strings manipulation functions

#----- public functions

# remove spaces from the beginning of the string
# arguments:
#   $1 : the string
# return:
#   The same string, without the spaces at the beginning
strings::ltrim() {
  local __string="$*"
  __string="${__string#"${__string%%[![:space:]]*}"}"
  echo "${__string}"
}

# remove spaces from the end of the string
# arguments:
#   $1 : the string
# return:
#   The same string, without the spaces at the end
strings::rtrim() {
  local __string="$*"
  __string="${__string%"${__string##*[![:space:]]}"}"
  echo "${__string}"
}

# remove spaces from the beginning and end of the string
# arguments:
#   $1 : the string
# return:
#   The same string, without the spaces at the beginning and the end
strings::trim() {
  local __string=$(strings::ltrim $1)
  echo "$(strings::rtrim ${__string})"
}

# convert a string to uppercase
#   $1 : the string
# return:
#   The same string, in uppercase
strings::to_upper() {
  local __string="$*"
  echo "${__string^^}"
}

# convert a string to lowercase
#   $1 : the string
# return:
#   The same string, in lowercase
strings::to_lower() {
  local __string="$*"
  echo "${__string,,}"
}
