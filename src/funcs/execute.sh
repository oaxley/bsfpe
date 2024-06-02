#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Command execute helper functions

#----- public functions

# wait until time has elapsed before executing a command
# arguments:
#   $1 : the time to wait
#   $2 : the command to execute
#   $* : the arguments of the command
# return:
#   the error code from the command
execute::wait_until() {
  local __sleeptime=$1
  local __command=$2
  shift 2

  # shellcheck disable=SC2086
  sleep ${__sleeptime} && ${__command} "$@"
}

# execute a command in the specified directory
# arguments:
#   $1 : the directory where the execution should take place
#   $2 : the command to execute
#   $* : the arguments for the command
# return:
#   the error code from the command
execute::run_in() {
  local __dir=$1
  local __command=$2
  shift 2

  [[ ! -d ${__dir} ]] && logger::error "Directory [${__dir}] does not exist!" && return 1

  # silently move to target
  # shellcheck disable=SC2164
  pushd "${__dir}" >/dev/null 2>&1

  ${__command} "$@"
  local __result=$?

  # shellcheck disable=SC2164
  popd >/dev/null 2>&1

  return ${__result}
}

# function that always return True
execute::true() {
  return 0
}

# function that always return False
execute::false() {
  return 1
}