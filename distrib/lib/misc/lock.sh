#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Implementation for lock acquire/release

#----- globals
# we select 968 as file descriptor, hopefully not used in the running script
__file_descriptor=968


#----- private functions
# create the lock file from the script name
lock::_lockfile_name() {
  local __script_name, __lockfile

  # retrieve the current script name, derive the lock file name from it
  __script_name=$(basename "$0")
  __lockfile="/tmp/${__script_name%.sh}.lock"

  # create the file if not already done
  [[ -e "${__lockfile}" ]] || touch "${__lockfile}"

  # return the filename
  echo "${__lockfile}"
}


#----- public functions

#.--
#.1 Acquire the lock
#.3H The function will create a specific lock file in \fB/tmp\fR associated with the script. !!
#.3H The lock file is not removed at the end and can be reused later on (or deleted)
#.3F The function returns True (0) if the lock was acquired, False (1) otherwise
#.--
lock::acquire() {
  local __lockfile

  # retrieve the name of the lock
  __lockfile=$(lock::_lockfile_name)

  # create a file descriptor on this file
  # shellcheck disable=SC2093
  eval "exec ${__file_descriptor}<>\"${__lockfile}\""

  # get the lock
  flock -xn ${__file_descriptor}
}

#.--
#.1 Release the lock
#.3H This function release the lock previously held with \fBlock::acquire\fR. !!
#.3H The specific lock file in \fB/tmp\fR associated with the script is not removed. !!
#.3F The function returns True (0) if the lock was released, False (1) otherwise
#.--
lock::release() {
  local __result

  # release the lock
  flock -u ${__file_descriptor}
  __result=$?

  # delete the file descriptor
  exec ${__file_descriptor}>&-

  return ${__result}
}