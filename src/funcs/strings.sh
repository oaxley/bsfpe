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
# arguments:
#   $1 : the string
# return:
#   The same string, in uppercase
strings::to_upper() {
  local __string="$*"
  echo "${__string^^}"
}

# convert a string to lowercase
# arguments:
#   $1 : the string
# return:
#   The same string, in lowercase
strings::to_lower() {
  local __string="$*"
  echo "${__string,,}"
}

# return the length of a string
# arguments:
#   $1 : the string
# return:
# the length of the string
strings::length() {
  local __string="$*"
  echo ${#__string}
}

# extract N characters from the left of a string
# arguments:
#   $1 : number of characters to extract
#   $2 : the string
# return:
#   the extracted characters
strings::left() {
  local __count=$1
  shift
  local __string="$*"
  echo ${__string:0:__count}
}

# extract N characters from the right of a string
# arguments:
#   $1 : number of characters to extract
#   $2 : the string
# return:
#   the extracted characters
strings::right() {
  local __count=$1
  shift
  local __string="$*"
  local __length=${#__string}
  local __pos=$(( __length - __count ))
  echo ${__string:__pos:__length}
}

# extract N characters from the string at the specified position
# arguments:
#   $1 : starting position
#   $2 : length
#   $* : the string
# return:
#   the extracted characters
strings::mid() {
  local __start=$1
  local __length=$2
  shift 2
  local __string="$*"

  echo ${__string:__start:__length}
}
