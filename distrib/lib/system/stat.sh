#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Stat functions for file flags/timestamp management

#.--
#.1 Retrieve the access time of a file
#.2 (filename){Name of the file}
#.3H Use the 'stat' command to retrieve file access time.
#.3F The value returned is the time since Epoch. !!
#.3F Function will return True (0) if stats can be retrieved, False (1) otherwise.
#.4 Get the last access time
#.4 $ system::file_access_time /bin/ls
#.--
system::file_access_time() {
  local __filename="$1"
  [[ ! -e ${__filename} ]] && return 1

  stat -c "%X" "${__filename}"
}

#.--
#.1 Retrieve the size of a file
#.2 (filename){Name of the file}
#.3H Use the 'stat' command to retrieve file size.
#.3F The value returned is in Bytes. !!
#.3F Function will return True (0) if stats can be retrieved, False (1) otherwise.
#.4 Get the size of the file
#.4 $ system::file_size /bin/ls
#.--
system::file_size() {
  local __filename="$1"
  [[ ! -e ${__filename} ]] && return 1

  stat -c "%s" "${__filename}"
}

#.--
#.1 Retrieve the permissions of a file
#.2 (filename){Name of the file}
#.3H Use the 'stat' command to retrieve file permissions.
#.3F The value returned is the octal form. !!
#.3F Function will return True (0) if stats can be retrieved, False (1) otherwise.
#.4 Get the permissions
#.4 $ system::file_perm /bin/ls
#.--
system::file_perm() {
  local __filename="$1"
  [[ ! -e ${__filename} ]] && return 1

  stat -c "%#a" "${__filename}"
}
