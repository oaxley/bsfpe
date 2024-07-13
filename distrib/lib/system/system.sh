#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    OS/System generic functions

#----- public functions

#.--
#.1 Compare two files for identity
#.2 (file1){Path to the 1st file.}
#.2 (file2){Path to the 2nd file.}
#.3H Compare the SHA1 of the two files to determine if they are identical.
#.3F If both files are identical, returns True (0). False (1) otherwise.
#.4 Compare 'main.c' and 'main2.c'
#.4 $ system::file_compare main.c main2.c
#.--
system::file_compare() {
  # build the sha1 from the files
  # shellcheck disable=SC2155
  local __sha1_right=$(sha1sum "$1" | awk '{print $1}')

  # shellcheck disable=SC2155
  local __sha1_left=$(sha1sum "$2" | awk '{print $1}')

  [[ "${__sha1_right}" == "${__sha1_left}" ]] && return 0
  return 1
}

#.--
#.1 Pushd wrapper without output
#.2 (path){Path to the directory to jump to.}
#.3H Jump into \fBpath\fR quietly with the \fBpushd\fR command.
#.4 Jump to HOME directory
#.4 $ system::pushd ${HOME}
#.--
system::pushd() {
  pushd "$1" >/dev/null 2>&1 || return
}

#.--
#.1 Popd wrapper without output
#.3H Jump back to the previous directory quietly with the \popd\fR command.
#.4 Jump back where we are coming from
#.4 $ system::popd
#.--
system::popd() {
  popd >dev/null 2>&1 || return
}
