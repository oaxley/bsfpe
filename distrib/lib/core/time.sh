#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Functions to manipulate the time

#----- public functions

#.--
#.1 Returns the time formatted
#.2 (datetime){(optional) Use \fBdatetime\fR as a reference instead of now}
#.3H This function will return only the time part of any datetime. !!
#.3H The output format by default is "+%H:%M:%S".
#.3F The function returns True (0) if successful, False (1) otherwise.
#.4 Return the time of now
#.4 $ date::time
#.4 Return the time somewhere in the future
#.4 $ date::date 1725478996
#.--
time::time() {
  local __datetime="$1"
  [[ -z "${__datetime}" ]] && __datetime=$(date "+%s")
  date --date="@${__datetime}" "+%H:%M:%S"
}

#.--
#.1 Add hours to a datetime
#.2 (hours){Number of hours to add}
#.2 (datetime){(optional) Use \fBdatetime\fR as a reference instead of now}
#.3H Add the number of hours specified to either the datetime passed in argument or now.
#.3F The function returns True (0) if successful, False (1) otherwise.
#.4 Add 2 hours to now
#.4 $ time::add_hours 2
#.4 Add 6 hours to this datetime
#.4 $ time::add_hours 6 1725478996
#.--
time::add_hours() {
  local __hours="$1"
  [[ -z "${__hours}" ]] && return 1

  local __datetime="$2"
  [[ -z "${__datetime}" ]] && __datetime=$(date "+%s")

  echo "$(( __datetime + __hours ))"
}

#.--
#.1 Substract hours to a datetime
#.2 (hours){Number of hours to substract}
#.2 (datetime){(optional) Use \fBdatetime\fR as a reference instead of now}
#.3H Substract the number of hours specified to either the datetime passed in argument or now.
#.3F The function returns True (0) if successful, False (1) otherwise.
#.4 Substract 2 hours to now
#.4 $ time::sub_hours 2
#.4 Substract 6 hours to this datetime
#.4 $ time::sub_hours 6 1725478996
#.--
time::sub_hours() {
  local __hours="$1"
  [[ -z "${__hours}" ]] && return 1

  local __datetime="$2"
  [[ -z "${__datetime}" ]] && __datetime=$(date "+%s")

  echo "$(( __datetime - __hours ))"
}

#.--
#.1 Return today's datetime
#.3H This function returns the datetime of the day as Epoch.
#.3F Time can be converted back with \fBtime::time\fR.
#.4 Get the current datetime
#.4 $ time::now
#.--
time::now() {
  date "+%s"
}


#.--
#.1 Returns the hours
#.2 (datetime){(optional) Use \fBdatetime\fR as a reference instead of now}
#.3H This function will return the hours of any time.
#.3F The function returns True (0) if successful, False (1) otherwise.
#.4 Return the hours of now
#.4 $ time::hours
#.4 Return the hours of the datetime passed in argument
#.4 $ time::hours 1725478996
#.--
time::hours() {
  local __datetime="$1"
  [[ -z "${__datetime}" ]] && __datetime=$(date "+%s")
  date --date="@${__datetime}" "+%H"
}

#.--
#.1 Returns the minutes
#.2 (datetime){(optional) Use \fBdatetime\fR as a reference instead of now}
#.3H This function will return the minutes of any time.
#.3F The function returns True (0) if successful, False (1) otherwise.
#.4 Return the minutes of now
#.4 $ time::minutes
#.4 Return the minutes of the datetime passed in argument
#.4 $ time::minutes 1725478996
#.--
time::minutes() {
  local __datetime="$1"
  [[ -z "${__datetime}" ]] && __datetime=$(date "+%s")
  date --date="@${__datetime}" "+%M"
}

#.--
#.1 Returns the seconds
#.2 (datetime){(optional) Use \fBdatetime\fR as a reference instead of now}
#.3H This function will return the seconds of any time.
#.3F The function returns True (0) if successful, False (1) otherwise.
#.4 Return the seconds of now
#.4 $ time::seconds
#.4 Return the seconds of the datetime passed in argument
#.4 $ time::seconds 1725478996
#.--
time::seconds() {
  local __datetime="$1"
  [[ -z "${__datetime}" ]] && __datetime=$(date "+%s")
  date --date="@${__datetime}" "+%S"
}

