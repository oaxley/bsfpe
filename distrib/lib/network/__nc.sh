#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Network functions with netcat ('nc') as a backend

#----- guards
__bin=$(which nc)
[[ -z ${__bin} ]] && return


#----- public functions

#.--
#.1 Test for connection
#.2 (host:port){The \fBhost\fR:\fBport\fR of the remote connection.}
#.3H This function will try to connect to the remote only to validate if the connection is opened. !!
#.3H This is useful in case you suspect a firewall is dropping the connection.
#.3F The function will return True (0) if the connection was successful, >0 otherwise.
#.4 Try to connect to Redis in the remote host
#.4 $ network::zero_connect 172.17.0.2:6319
#.--
network::zero_connect() {
  local __result

  # split host/port
  [[ "$1" =~ ([^:]+):([0-9]+) ]]

  # suppress the output in non-interactive
  if [[ "$-" != *i* ]]; then
    nc -zv "${BASH_REMATCH[1]}" "${BASH_REMATCH[2]}" >/dev/null 2>&1
    __result=$?
  else
    nc -zv "${BASH_REMATCH[1]}" "${BASH_REMATCH[2]}"
    __result=$?
  fi

  return ${__result}
}

