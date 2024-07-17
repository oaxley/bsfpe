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
#.--
#.1 Stack size
#.3H This function returns the number of elements currently in the stack.
#.4 Get the stack size
#.4 $ stack::push 10; stack::push 20; stack::count      # output: 2
#.--
stack::count() {
  echo "${#__stack[@]}"
}

#.--
#.1 Stack print
#.3H This function prints the content of the stack. !!
#.3H Its use is mainly for debugging during development.
#.4 Print the stack
#.4 $ stack::print      # output: [10 20]
#.--
stack::print() {
  echo "${__stack[@]}"
}

#.--
#.1 Stack push
#.2 (value){The value to push on top of the stack.}
#.3H Push a new value on top of the stack, increasing the stack size by 1.
#.4 Push the value '10' on top of the stack
#.4 $ stack::push 10
#.--
stack::push() {
  __stack+=("$1")
}

#.--
#.1 Stack pop
#.3H Removes the value on top of the stack and returns it to the caller.
#.3H The stack size is reduced by 1 after this.
#.4 Remove the top value
#.4 $ stack::pop
#.--
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

#.--
#.1 Stack top
#.3H Read the value on top of the stack and returns it to the caller.
#.3H The stack size is not modified by this function.
#.4 Read the top value
#.4 $ stack::top
#.--
stack::top() {
  local __index
  __index=$(( $(stack::count) - 1 ))
  (( __index < 0 )) && return 1
  echo "${__stack[${__index}]}"
}

#.--
#.1 Stack duplicate
#.3H Duplicate the value on top of the stack.
#.3H The stack size is increased by 1 after this.
#.4 Duplicate the top value
#.4 $ stack::dup
#.--
stack::dup() {
  local __index
  __index=$(( $(stack::count) - 1 ))
  (( __index < 0 )) && return 1
  __stack+=( "${__stack[${__index}]}" )
}

#.--
#.1 Stack drop
#.3H Removes the value on top of the stack and but does not return it to the caller.
#.3H The stack size is reduced by 1 after this.
#.4 Remove the top value
#.4 $ stack::drop
#.--
stack::drop() {
  local __index
  __index=$(( $(stack::count) - 1 ))
  (( __index < 0 )) && return 1
  # shellcheck disable=SC2184,SC2086
  unset __stack[${__index}]
}

#.--
#.1 Stack swap
#.3H Swap the top element and the one just below.
#.3H The stack size is not modified after this.
#.4 Swap the values
#.4 $ stack::swap
#.--
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

#.--
#.1 Stack rotate
#.3H Rotate the element from the stack.
#.3H After this function is executed, the element at the bottom of the stack is now the top element. !!
#.3H The previous top element, is now the element just below.
#.4 Rotate the stack
#.4 $ stack::rotate
#.--
stack::rotate() {
  local __count
  __count=$(stack::count)
  (( __count == 0 )) && return 1

  __stack+=("${__stack[0]}")
  # shellcheck disable=SC2184,SC2086
  unset __stack[0]
}

#.--
#.1 Stack clear
#.3H Remove all the elements in the stack.
#.3H The stack size will be 0 after this command.
#.4 Clear the stack
#.4 $ stack::clear
#.--
stack::clear() {
  __stack=()
}
