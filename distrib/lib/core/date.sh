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
#.4 Get the day of the week from a standard date
#.4 $ date::weekday "2024-09-04T19:43:16"   # output: Wednesday
#.--
date::weekday() {
  local __datetime="$1"
  [[ -z "$1" ]] && __datetime=$(date "+%s")

  # detect epoch
  [[ "${__datetime}" =~ ^[0-9]+$ ]]

  # not an epoch
  if (( $? == 1 )); then
    __datetime=$(date::to_epoch "$1")
  fi

  # retrieve the week day
  date --date="@${__datetime}" "+%A"
}