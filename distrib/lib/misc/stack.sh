#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    In-memory stack machine

#----- imports
# shellcheck disable=SC1091
source "${BSFPE_LIBRARY_DIR}/lib/core/logger.sh"

#----- globals
# the main stack
__stack=()

#----- public functions
# return the number of elements in the stack
stack::count() {
  echo "${#__stack[@]}"
}

# print the stack (for debug)
stack::print() {
  echo "${__stack[@]}"
}

# add a new item on top of the stack
# arguments:
#   $1 : the element to push on the stack
stack::push() {
  __stack+=("$1")
}

# remove the last element from the top
# returns:
#   the last element on top of the stack
stack::pop() {
  local __index
  local __item

  __index=$(( $(stack::count) - 1 ))
  (( __index < 0 )) && return 1

  __item=${__stack[${__index}]}

  # shellcheck disable=SC2184,SC2086
  unset __stack[${__index}]

  echo "${__item}"
}

# get the top element, without removing it
stack::top() {
  local __index
  __index=$(( $(stack::count) - 1 ))
  (( __index < 0 )) && return 1
  echo "${__stack[${__index}]}"
}

# duplicate top item
stack::dup() {
  local __index
  __index=$(( $(stack::count) - 1 ))
  (( __index < 0 )) && return 1
  __stack+=( "${__stack[${__index}]}" )
}

# drop the top item
stack::drop() {
  local __index
  __index=$(( $(stack::count) - 1 ))
  (( __index < 0 )) && return 1
  # shellcheck disable=SC2184,SC2086
  unset __stack[${__index}]
}

# swap the top 2 elements
stack::swap() {
  local __index1
  local __index2
  local __tmp

  __index1=$(( $(stack::count) - 1 ))
  (( __index1 <= 0 )) && return 1
  __index2=$(( __index1 - 1 ))

  __tmp=${__stack[__index1]}
  __stack[__index1]=${__stack[__index2]}
  __stack[__index2]=${__tmp}
}

# rotate the stack. bottom of the stack -> top of the stack
stack::rotate() {
  local __count
  __count=$(stack::count)
  (( __count == 0 )) && return 1

  __stack+=("${__stack[0]}")
  # shellcheck disable=SC2184,SC2086
  unset __stack[0]
}

# clear the whole stack
stack::clear() {
  __stack=()
}
