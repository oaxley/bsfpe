#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    OS/System directory functions

#----- public functions

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
  popd >/dev/null 2>&1 || return
}

#.--
#.1 Count the number of files in a directory
#.2 (path){The path to the directory.}
#.3H This function will return the number of files present in the directory specified by \fBpath\fR.
#.3F The function returns True (0) if successful, False (1) otherwise.
#.4 Count the number of hidden files in HOME
#.4 $ system::num_files $HOME/.*
#.--
system::num_files() {
  echo "$#"
}