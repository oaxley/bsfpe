#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Logger functions

#----- globals

# default debug level
export BSFPE_DEFAULT_LOGGER_LEVEL=20


#----- private functions

# default printer for log messages
# arguments:
#   $1 : logger level
#   $2 : logger message
logger::_print() {
  local __loglevel=$1

  # shellcheck disable=SC2155
  local __date=$(date "+%Y-%m-%d %H:%M:%S,%N" | cut -c-23)

  # ensure we are at the right level
  if (( __loglevel >= BSFPE_DEFAULT_LOGGER_LEVEL )); then
    shift     # remove the loglevel
    # shellcheck disable=SC2086
    echo "${__date}" "$(logger::_fromValue ${__loglevel})" "$*"
  fi
}

# retrieve the level name from its value
logger::_fromValue() {
  case "$1" in
    "10") echo "DEBUG" ;;
    "20") echo "INFO" ;;
    "30") echo "WARNING" ;;
    "40") echo "ERROR" ;;
    "50") echo "CRITICAL" ;;
    *)    echo "INFO" ;;
  esac
}

# retrieve the level value from its name
logger::_fromName() {
  # ensure the name is in uppercase
  # shellcheck disable=SC2155
  local name=$(echo "$1" | tr "[:lower:]" "[:upper:]")
  case "$name" in
    "DEBUG")    echo 10 ;;
    "INFO")     echo 20 ;;
    "WARNING")  echo 30 ;;
    "ERROR")    echo 40 ;;
    "CRITICAL") echo 50 ;;
    *)          echo 20 ;;
  esac
}

#----- public functions
# set the log level
# arguments:
#   $1 : the level name
logger::setLogLevel() {
  BSFPE_DEFAULT_LOGGER_LEVEL=$(logger::_fromName "$1")
}

# print a DEBUG message
# arguments:
#   $1 : the user message
logger::debug() {
  logger::_print 10 "$@"
}

# print a INFO message
# arguments:
#   $1 : the user message
logger::info() {
  logger::_print 20 "$@"
}

# print a WARNING message
# arguments:
#   $1 : the user message
logger::warning() {
  logger::_print 30 "$@"
}

# print a ERROR message
# arguments:
#   $1 : the user message
logger::error() {
  logger::_print 40 "$@"
}

# print a CRITICAL message
# arguments:
#   $1 : the user message
logger::critical() {
  logger::_print 50 "$@"
}
