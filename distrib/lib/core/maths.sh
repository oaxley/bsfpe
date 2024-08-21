#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Basic statistical maths functions

#----- globals
__values=()

#----- functions

#.--
#.1 Add value to the array
#.2 (value1, value2, ...){The values to insert into the array.}
#.4 Add 3 values to the array
#.4 maths::append 10 20 30
#.--
maths::append() {
  __values+=("$@")
}

#.--
#.1 Clear the whole array
#.--
maths::clear() {
  __values=()
}

#.--
#.1 Returns the length of the array
#.--
maths::length() {
  echo ${#__values[@]}
}

#.--
#.1 Returns the minimum value of the array
#.--
maths::minimum() {
  local __min=${__values[0]}
  for __value in "${__values[@]}"; do
    if (( __value < __min )); then
      __min=${__value}
    fi
  done
  echo "${__min}"
}

#.--
#.1 Returns the maximum value of the array
#.--
maths::maximum() {
  local __max=${__values[0]}
  for __value in "${__values[@]}"; do
    if (( __value > __max )); then
      __max=${__value}
    fi
  done
  echo "${__max}"
}

#.--
#.1 Returns the sum of the array
#.--
maths::sum() {
  local __sum=0
  for __value in "${__values[@]}"; do
    __sum=$(( __sum + __value ))
  done
  echo "${__sum}"
}

#.--
#.1 Returns the average of the array
#.--
maths::average() {
  local __sum, __len

  __sum=$(maths::sum)
  __len=${#__values[@]}
  echo "scale=3; ${__sum} / ${__len}" | bc -l
}

#.--
#.1 Returns the median value of the array
#.--
maths::median() {
  local __length=${#__values[@]}
  local __middle=$(( __length / 2 ))
  # shellcheck disable=SC2207
  local __sorted=($(printf "%s\n" "${__values[@]}" | sort -n ))

  if (( __length % 2 == 0 )); then
    echo "scale=3; ( ${__sorted[$__middle]} + ${__sorted[$__middle - 1]}) / 2" | bc -l
  else
    echo "${__sorted[$__middle]}"
  fi
}
