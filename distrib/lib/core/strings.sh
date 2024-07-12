#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Strings manipulation functions

#----- public functions

#.--
#.1 Remove spaces at the beginning of the string
#.2 (string){The string to trim}
#.3H Remove the spaces in front of the string and return a new string.
#.4 Remove heading spaces in the string
#.4 $ strings::ltrim "   Hello, World!"     # output: [Hello, World!]
#.--
strings::ltrim() {
  local __string="$*"
  __string="${__string#"${__string%%[![:space:]]*}"}"
  echo "${__string}"
}

#.--
#.1 Remove spaces at the end of the string
#.2 (string){The string to trim}
#.3H Remove the spaces at the end of the string and return a new string.
#.4 Remove leading spaces in the string
#.4 $ strings::rtrim "Hello, World!    "     # output: [Hello, World!]
#.--
strings::rtrim() {
  local __string="$*"
  __string="${__string%"${__string##*[![:space:]]}"}"
  echo "${__string}"
}

#.--
#.1 Remove spaces at the beginning and end of the string
#.2 (string){The string to trim}
#.3H Remove the spaces at the beginning and end of the string and return a new string.
#.4 Remove leading spaces in the string
#.4 $ strings::rtrim "    Hello, World!    "     # output: [Hello, World!]
#.--
strings::trim() {
  # shellcheck disable=SC2155
  local __string=$(strings::ltrim "$1")
  strings::rtrim "${__string}"
}

#.--
#.1 Convert the string to uppercase
#.2 (string){The string to convert}
#.3H Convert all the ASCII characters of the string to uppercase. Returns a new string.
#.4 Convert the string to uppercase
#.4 $ strings::to_upper "Hello, World!"     # output: [HELLO, WORLD!]
#.--
strings::to_upper() {
  local __string="$*"
  echo "${__string^^}"
}

#.--
#.1 Convert the string to lowercase
#.2 (string){The string to convert}
#.3H Convert all the ASCII characters of the string to lowercase. Returns a new string.
#.4 Convert the string to lowercase
#.4 $ strings::to_lower "Hello, World!"     # output: [hello, world!]
#.--
strings::to_lower() {
  local __string="$*"
  echo "${__string,,}"
}

#.--
#.1 Return the length of the string
#.2 (string){The string}
#.3H Returns the length of the string passed in parameters. The string is not modified.
#.4 Returns the length of the string
#.4 $ strings::length "Hello, World!"     # output: 13
#.--
strings::length() {
  local __string="$*"
  echo "${#__string}"
}

#.--
#.1 Extract N characters from the beginning
#.2 (count){Number of characters to extract}
#.2 (string){The string}
#.3H Extract \fBcount\fR characters from the beginning of \fBstring\fR and returns a new string.
#.4 Extract the first 5 characters
#.4 $ strings::left 5 "Hello, World!"     # output: [Hello]
#.--
strings::left() {
  local __count=$1
  shift
  local __string="$*"
  echo "${__string:0:__count}"
}

#.--
#.1 Extract N characters from the end
#.2 (count){Number of characters to extract}
#.2 (string){The string}
#.3H Extract \fBcount\fR characters from the end of \fBstring\fR and returns a new string.
#.4 Extract the last 6 characters
#.4 $ strings::right 6 "Hello, World!"     # output: [World!]
#.--
strings::right() {
  local __count=$1
  shift
  local __string="$*"
  local __length=${#__string}
  local __pos=$(( __length - __count ))
  echo "${__string:__pos:__length}"
}

#.--
#.1 Extract N characters from the string
#.2 (pos){Starting position for extract}
#.2 (count){The number of characters to extract}
#.2 (string){The string}
#.3H Extract \fBcount\fR characters from \fBpos\fR and returns a new string. !!
#.3H The beginning of the string is 0.
#.4 Extract 6 characters from position 3
#.4 $ strings::mid 3 6 "Hello, World!"     # output: [lo, Wo]
#.--
strings::mid() {
  local __start=$1
  local __length=$2
  shift 2
  local __string="$*"

  echo "${__string:__start:__length}"
}
