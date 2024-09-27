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
#.--
#.1 Set the current log level
#.2 (log_level){the new log level}
#.3H The available log level are:
#.3H .br
#.3H - \fBDEBUG\fR !!
#.3H - \fBINFO\fR (default) !!
#.3H - \fBWARNING\fR !!
#.3H - \fBERROR\fR !!
#.3H - \fBCRITICAL\fR !!
#.3F The level is set until another call to the function changes it.
#.4 Set the LOG Level to CRITICAL
#.4 $ logger::setLogLevel CRITICAL
#.--
logger::set_log_level() {
  BSFPE_DEFAULT_LOGGER_LEVEL=$(logger::_fromName "$1")
}

#.--
#.1 Print a DEBUG message
#.2 (message){the message to output with this level}
#.3H Print a message at the DEBUG level.
#.--
logger::debug() {
  logger::_print 10 "$@"
}

#.--
#.1 Print a INFO message
#.2 (message){the message to output with this level}
#.3H Print a message at the INFO level.
#.--
logger::info() {
  logger::_print 20 "$@"
}

#.--
#.1 Print a WARNING message
#.2 (message){the message to output with this level}
#.3H Print a message at the WARNING level.
#.--
logger::warning() {
  logger::_print 30 "$@"
}

#.--
#.1 Print a ERROR message
#.2 (message){the message to output with this level}
#.3H Print a message at the ERROR level.
#.--
logger::error() {
  logger::_print 40 "$@"
}

#.--
#.1 Print a CRITICAL message
#.2 (message){the message to output with this level}
#.3H Print a message at the CRITICAL level.
#.--
logger::critical() {
  logger::_print 50 "$@"
}
