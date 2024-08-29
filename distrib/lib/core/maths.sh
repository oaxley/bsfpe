#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Basic statistical maths functions

#----- globals
__maths_values=()

#----- functions

#.--
#.1 Add value to the array
#.2 (value1, value2, ...){The values to insert into the array.}
#.4 Add 3 values to the array
#.4 $ maths::append 10 20 30
#.--
maths::append() {
  __maths_values+=("$@")
}

#.--
#.1 Clear the whole array
#.3H All the values present in the array are removed.
#.4 Clean the array
#.4 $ maths::clear
#.--
maths::clear() {
  __maths_values=()
}

#.--
#.1 Returns the length of the array
#.3H This function will return the number of values currently in the array.
#.4 Get the number of values in the array
#.4 $ maths::length
#.--
maths::length() {
  echo ${#__maths_values[@]}
}

#.--
#.1 Returns the minimum value of the array
#.3H The function will return the minimum value currently in the array.
#.4 Return the min
#.4 $ maths::minimum
#.--
maths::minimum() {
  local __min=${__maths_values[0]}
  for __value in "${__maths_values[@]}"; do
    if (( __value < __min )); then
      __min=${__value}
    fi
  done
  echo "${__min}"
}

#.--
#.1 Returns the maximum value of the array
#.3H The function will return the maximum value currently in the array.
#.4 Return the max
#.4 $ maths::maximum
#.--
maths::maximum() {
  local __max=${__maths_values[0]}
  for __value in "${__maths_values[@]}"; do
    if (( __value > __max )); then
      __max=${__value}
    fi
  done
  echo "${__max}"
}

#.--
#.1 Returns the sum of the array
#.3H The function will sum all the values in the array.
#.4 Sum all the values
#.4 $ maths::sum
#.--
maths::sum() {
  local __sum=0
  for __value in "${__maths_values[@]}"; do
    __sum=$(( __sum + __value ))
  done
  echo "${__sum}"
}

#.--
#.1 Returns the average of the array
#.3H The function will return the mean value of the array.
#.3F The value returned has 3 decimals.
#.4 Return the mean
#.4 $ maths::average
#.--
maths::average() {
  local __sum=$(maths::sum)
  local __len=${#__maths_values[@]}
  echo "scale=3; ${__sum} / ${__len}" | bc -l
}

#.--
#.1 Returns the median value of the array
#.3H The function will return the median value of the array.
#.3F The value returned has 3 decimals.
#.4 Return the median value
#.4 $ maths::median
#.--
maths::median() {
  local __length=${#__maths_values[@]}
  local __middle=$(( __length / 2 ))
  # shellcheck disable=SC2207
  local __sorted=($(printf "%s\n" "${__maths_values[@]}" | sort -n ))

  if (( __length % 2 == 0 )); then
    echo "scale=3; ( ${__sorted[$__middle]} + ${__sorted[$__middle - 1]}) / 2" | bc -l
  else
    echo "${__sorted[$__middle]}"
  fi
}

#.--
#.1 Returns the variance of the array
#.3H The function will return the variance of the values currently in the array.
#.3F The value returned has 3 decimals.
#.4 Return the variance
#.4 $ maths::variance
#.--
maths::variance() {
  local __mean=$(maths::average)
  local __sum=0
  local __diff=0
  local __length=${#__maths_values[@]}
  for __value in "${__maths_values[@]}"; do
    __diff=$(echo "scale=3; ${__value} - ${__mean}" | bc -l)
    __sum=$(echo "scale=3; ${__sum} + ${__diff} * ${__diff}" | bc -l)
  done

  echo "scale=3; ${__sum} / ${__length}" | bc -l
}

#.--
#.1 Returns the standard deviation
#.3H The function will return the standard deviation of the values currently in the array.
#.3F The value returned has 3 decimals.
#.4 Return the stddev
#.4 $ maths::stddev
#.--
maths::stddev() {
  local __variance
  __variance=$(maths::variance)
  echo "scale=3; sqrt( ${__variance} )" | bc -l
}

#.--
#.1 Returns the kth percentile of the array
#.2 (kth){Percentile value (10, 20, ...)}
#.3F The value returned has 3 decimals.
#.4 Get the 75th percentile of the array
#.4 $ maths::percentile 75
#.--
maths::percentile() {

  local __percent="$1"
  # shellcheck disable=SC2207
  local __sorted=($(printf "%s\n" "${__maths_values[@]}" | sort -n ))

  # boundaries checking
  (( __percent < 0 || __percent > 100 )) && return 1
  (( __percent == 0 )) && echo "${__sorted[0]}" && return 0
  (( __percent == 100 )) && echo "${__sorted[-1]}" && return 0

  # compute the index
  local __length=${#__maths_values[@]}
  local __index=$(echo "scale=2; (${__percent} * (${__length} - 1)) / 100" | bc -l)

  # get the interger/decimal part
  local __int=${__index%.*}
  local __dec=${__index#*.}

  # lower & upper value
  local __lower=${__sorted[${__int}]}
  local __upper=${__sorted[${__int} + 1]}

  # compute the value
  echo "scale=3; ${__lower} + (${__upper} - ${__lower}) * (${__dec} / 100)" | bc -l
}