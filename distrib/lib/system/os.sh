#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    OS determination functions

#----- public functions
#.--
#.1 Return the OS name
#.3H This function returns the OS name as returned by the \fBuname\fR command.
#.--
system::os_name() {
  uname -s
}

#.--
#.1 Return the OS version
#.3H This function returns the OS version as returned by the \fBuname\fR command.
#.--
system::os_version() {
  uname -r
}

