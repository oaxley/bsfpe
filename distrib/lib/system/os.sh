#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    OS determination functions

#----- public functions
# retrieve OS Name
system::os_name() {
  uname -s
}

# retrieve OS Version
system::os_version() {
  uname -r
}

