#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Functions to manipulate the dates and times

#----- functions

#.--
#.1 Convert a date to Epoch
#.2 (value){A date/time value}
#.3H Convert a standard datetime to its equivalent in Epoch.
#.4 Convert the date
#.4 $ date::to_epoch "2024-09-04T19:43:16"    # output: 1725478996
#.--
date::to_epoch() {
  date --date="$1" "+%s"
}

#.--
#.1 Convert a date from Epoch
#.2 (value){An Epoch value}
#.2 (format){An optional format for the conversion (see below)}
#.3H Convert an Epoch timestamp to its standard equivalent
#.3F The default format for the conversion is "+%Y-%m-%dT%H:%M:%S". !!
#.3F See date(1) for different format
#.4 Convert the date to its human readable equivalent
#.4 $ date::from_epoch 1725478996   # output: 2024-09-04T19:43:16
#.--
date::from_epoch() {
  local __format="+%Y-%m-%dT%H:%M:%S"
  [[ -n "$2" ]] && __format="$2"
  date --date="@$1" "${__format}"
}

#.--
#.1 Get the day of the week
#.2 (date){(optional) Use \fBdate\fR as a reference instead of today}
#.3H Compute the day of the week from either \fBtoday\fR or the date passed in argument.
#.4 Get the day of the week from an epoch value
#.4 $ date::weekday 1725478996      # output: Wednesday
#.--
date::weekday() {
  local __datetime="$1"
  [[ -z "$1" ]] && __datetime=$(date "+%s")
  date --date="@${__datetime}" "+%A"
}

#.--
#.1 Get the month name
#.2 (date){(optional) Use \fBdate\fR as a reference instead of today}
#.3H Compute the month from either \fBtoday\fR or the date passed in argument.
#.4 Get the month from an epoch value
#.4 $ date::month_name 1725478996      # output: September
#.--
date::month_name() {
  local __datetime="$1"
  [[ -z "$1" ]] && __datetime=$(date "+%s")
  date --date="@${__datetime}" "+%B"
}

#.--
#.1 Add days to a date
#.2 (days){Number of days to add}
#.2 (date){(optional) Use \fBdate\fR as a date instead of today}
#.3H Add the number of days specified to either the date passed in argument or the current date.
#.3F The function returns True (0) if successful, False (1) otherwise.
#.4 Add 3 days to the current date
#.4 $ date::add_days 3
#.4 Add 1 day to this date (given as epoch format)
#.4 $ date::add_days 1 1725478996
#.--
date::add_days() {
  local __days="$1"
  [[ -z "${__days}" ]] && return 1

  local __datetime="$2"
  [[ -z "${__datetime}" ]] && __datetime=$(date "+%s")

  echo $(( __datetime + __days * 86400 ))
}

#.--
#.1 Substract days to a date
#.2 (days){Number of days to substract}
#.2 (date){(optional) Use \fBdate\fR as a reference instead of today}
#.3H Substract the number of days specified to either the date passed in argument or the current date.
#.3F The function returns True (0) if successful, False (1) otherwise.
#.4 Substract 3 days from the current date
#.4 $ date::sub_days 3
#.4 Substract 1 day from this date (given as epoch format)
#.4 $ date::sub_days 1 1725478996
#.--
date::sub_days() {
  local __days="$1"
  [[ -z "${__days}" ]] && return 1

  local __datetime="$2"
  [[ -z "${__datetime}" ]] && __datetime=$(date "+%s")

  echo $(( __datetime - __days * 86400 ))
}

#.--
#.1 Compute if a year is leap
#.2 (date){(optional) Use \fBdate\fR as a reference instead of today}
#.3H Function will determine if a year is leap or not.
#.3F The function returns True (0) if successful, False (1) otherwise.
#.4 Is the current year leap?
#.4 $ date::is_leap
#.4 Is this year leap?
#.4 $ date::is_leap 2024
#.4 Is the year in this date, is leap?
#.4 $date::is_leap 1725478996
#.--
date::is_leap() {
  local __year="$1"
  [[ -z "${__year}" ]] && __year=$(date "+%s")

  # convert datetime to year
  if (( ${#__year} > 4 )); then
    __year=$(date --date="@${__year}" "+%Y")
  fi

  # algorithm to determine if a year is leap
  (( ( __year % 4 == 0 && __year % 100 != 0 ) || __year % 400 == 0 )) && return 0
  return 1
}

#.--
#.1 Return today's datetime
#.3H This function returns the datetime of the day as Epoch.
#.3F Date can be converted back with \fBdate::from_epoch\fR.
#.4 Get the current datetime
#.4 $ date::today
#.--
date::today() {
  date "+%s"
}

#.--
#.1 Return tomorrow's datetime
#.3H This function returns the datetime of the next day as Epoch.
#.3F Date can be converted back with \fBdate::from_epoch\fR.
#.4 Get tomorrow's datetime
#.4 $ date::tomorrow
#.--
date::tomorrow() {
  # shellcheck disable=SC2155
  local __datetime=$(date "+%s")

  # add 24 * 60 * 60 (86400) seconds
  echo "$(( __datetime + 86400 ))"
}

#.--
#.1 Return yesterday's datetime
#.3H This function returns the datetime of the previous day as Epoch.
#.3F Date can be converted back with \fBdate::from_epoch\fR.
#.4 Get yesterday's datetime
#.4 $ date::yesterday
#.--
date::yesterday() {
  # shellcheck disable=SC2155
  local __datetime=$(date "+%s")

  # add 24 * 60 * 60 (86400) seconds
  echo "$(( __datetime - 86400 ))"
}
