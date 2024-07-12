#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Command execute helper functions

#----- public functions

#.--
#.1 Execute a command after time has elapsed
#.2 (period){Time in seconds to wait before running the command}
#.2 (command){The command to execute}
#.2 ($*){The arguments for the command}
#.3H Wait the for the \fBperiod\fR to elapsed before executing the command.
#.3F Returns the status of the executed command in $?.
#.4 Execute the removal of the file after 10s
#.4 $ execute::wait_until 10 rm -f /tmp/lock_file
#.--
execute::wait_until() {
  local __sleeptime=$1
  local __command=$2
  shift 2

  # shellcheck disable=SC2086
  sleep ${__sleeptime} && ${__command} "$@"
}

#.--
#.1 Execute a command in the specified directory
#.2 (path){The directory where to execute the command}
#.2 (command){The command to execute}
#.2 ($*){The arguments for the command}
#.3H The command will be executed in the specified directory.
#.3H After the command has been executed, the user will be back in the original directory.
#.3F The status of the executed command is returned in $?
#.4 Execute the tar command in /tmp
#.4 $ execute::run_in /tmp tar xvf ${HOME}/archives/documents.tgz
#.--
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

#.--
#.1 Return True in all conditions
#.3H The command will always returned True (0).
#.3H It is most of the time useful as a return statement or in conditionals.
#.4 Always execute the cat command
#.4 $ execute::true && cat /proc/cpuinfo
#.--
execute::true() {
  return 0
}

#.--
#.1 Return False in all conditions
#.3H The command will always returned False (1).
#.3H It is most of the time useful as a return statement or in conditionals.
#.4 Never execute the cat command
#.4 $ execute::false && cat /proc/cpuinfo
#.--
execute::false() {
  return 1
}