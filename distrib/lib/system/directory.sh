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
  popd >dev/null 2>&1 || return
}
