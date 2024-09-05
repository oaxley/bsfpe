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


