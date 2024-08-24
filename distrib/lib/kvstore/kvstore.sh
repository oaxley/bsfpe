#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Key/Value store for shell scripts

#----- globals

# retrieve the script name and location
SCRIPT_DIR=$(dirname "$0")
if [[ "${SCRIPT_DIR}" == "." ]]; then
  SCRIPT_DIR=$(pwd)
fi

# store location
if [[ -z ${XDG_CONFIG_DIR} ]]; then
  STORE_PATH=${HOME}/.kvstore
else
  [[ ! -d ${XDG_CONFIG_DIR} ]] && mkdir -p "${XDG_CONFIG_DIR}/user"
  STORE_PATH="${XDG_CONFIG_DIR}/user/kvstore"
fi


#----- functions
#.--
#.1 Create a new key/value pair
#.2 (key){key to insert.}
#.2 (value|@TTL){value to associate with the key, or TTL to set.}
#.3H Insert a new key/value pair or add a TTL to an existing key. !!
#.3H In its first form, a new value is inserted in the store and associated with the key. !!
#.3H When the value starts with '@', set a Time To Live (TTL) to an existing key.
#.3H The TTL is expressed in seconds.
#.3F Keys those TTL has elapsed are non longer available. Keys with a TTL of 0 (default) do not expire. !!
#.3F Function returns True (0) when successful, False (1) otherwise.
#.4 Create a new key 'my_string' in the store
#.4 $ kvstore::set my_string "Hello, World!"
#.4 Add a TTL of 5 minutes (300 seconds) to the key 'my_string'
#.4 $ kvstore::set my_string @300
#.--
kvstore::set() {
  local __key, __value, __data, __ttl
  local __value_b64, __datetime

  # retrieve the key and the value from the cmdline
  __key="$1"; shift
  __value="$*"

  # no value specified
  [[ -z "${__value}" ]] && return 1

  # check for the timestamp marker
  if [[ "${__value:0:1}" == "@" ]]; then
    # retrieve the last occurence of the key
    __data=$(grep "^${__key}:" "${STORE_PATH}" | tail -1)
    [[ -z "${__data}" ]] && return 1

    # split data in parts
    [[ "${__data}" =~ ^([^:]+):([0-9]+):(.*) ]]
    __value_b64="${BASH_REMATCH[3]}"

    # current datetime
    __datetime=$(date "+%s")

    # check if the key is not expired already
    (( BASH_REMATCH[2] > 0 )) && (( __datetime > BASH_REMATCH[2] )) && return 1

    # set the new TTL
    __ttl=$(( __datetime + ${__value:1} ))
  else
    # encode the value to base64
    __value_b64=$(echo "${__value}" | base64 -w0)
    __ttl=0
  fi

  # add the new entry
  echo "${__key}:${__ttl}:${__value_b64}" >> "${STORE_PATH}"
}

#.--
#.1 Get the value associated with a key
#.2 (key){the key to lookup in the store.}
#.3H Only keys that have not expired can be retrieved.
#.4 Retrieve the value associated with 'my_string'
#.4 $ kvstore::get my_string
#.--
kvstore::get() {
  local __key, __value, __datetime

  # exit if the store does not exist
  [[ ! -e "${STORE_PATH}" ]] && return 1

  # retrieve the key from the cmdline
  __key="$1"

  # no key specified
  [[ -z "${__key}" ]] && return 1

  # retrieve the last occurence of the key
  __value=$(grep "^${__key}:" "${STORE_PATH}" | tail -1)
  [[ -z "${__value}" ]] && return 1

  # split the data in parts
  [[ "${__value}" =~ ^([^:]+):([0-9]+):(.*) ]]

  if (( BASH_REMATCH[2] > 0 )); then
    # there is a TTL, check against the current time
    __datetime=$(date "+%s")
    (( __datetime > BASH_REMATCH[2] )) && return 1
  fi

  echo "${BASH_REMATCH[3]}" | base64 -d
}

#.--
#.1 Remove a key from the store
#.2 (key){the key to lookup in the store.}
#.3F Once the key has been deleted, it cannot be retrieved.
#.4 Delete the key 'my_string' from the store
#.4 $ kvstore::del my_string
#.--
kvstore::del() {
  local __key, __value, __ttl, __datetime

  # exit if the store does not exist
  [[ ! -e "${STORE_PATH}" ]] && return 1

  # retrieve the key from the cmdline
  __key="$1"

  # no key specified
  [[ -z "${__key}" ]] && return 1

  # retrieve the last occurence of the key
  __value=$(grep "^${__key}:" "${STORE_PATH}" | tail -1)
  [[ -z "${__value}" ]] && return 1

  # set the TTL to 300s from now
  __datetime=$(date "+%s")
  __ttl=$(( __datetime - 300 ))

  # add a new line in the store with only the key/ttl
  echo "${__key}:${__ttl}:dummy" >> "${STORE_PATH}"
}

#.--
#.1 Clean the store from expired keys
#.3H This command will effectively remove keys that are no longer relevant or expired from the store.
#.3H Modifying the store while the command is running will lead to an undefined state of the store. !!
#.3H It is preferable to run this command automatically when there are no activities.
#.4 Clean the store
#.4 $ kvstore::clean
#.--
kvstore::clean() {
  local __datetime, __key, __value, __elements

  # exit if the store does not exist
  [[ ! -e "${STORE_PATH}" ]] && return 1

  __datetime=$(date "+%s")

  # we store temporarly the keys in an associative array
  # to remove duplicates and keep only the last occurence
  declare -A __elements
  while read -r __value; do
    # split data
    [[ "${__value}" =~ ^([^:]+):([0-9]+):(.*) ]]
    __elements["${BASH_REMATCH[1]}"]="${__value}"
  done < "${STORE_PATH}"

  # create a temporary store with the elements
  for __key in "${!__elements[@]}"; do
    __value="${__elements[${__key}]}"

    # split data
    [[ "${__value}" =~ ^([^:]+):([0-9]+):(.*) ]]

    # remove expired items
    (( BASH_REMATCH[2] > 0 )) && (( __datetime > BASH_REMATCH[2] )) && continue

    echo "${__value}" >> "${STORE_PATH}.tmp"
  done

  # switch to new store
  mv -f "${STORE_PATH}.tmp" "${STORE_PATH}"
}

#.--
#.1 Print the keys available in the store
#.3H This command will print all the available keys and their corresponding TTL (if any).
#.3H It is mainly a debug command for scripts.
#.4 Print the keys available in the store
#.4 $ kvstore::print
#.--
kvstore::print() {
  local __datetime, __key, __value, __ttl, __elements

  # exit if the store does not exist
  [[ ! -e "${STORE_PATH}" ]] && return 1

  __datetime=$(date "+%s")

  # store key in an associative array, to keep only last occurence
  declare -A __elements
  while read -r __value; do
    # split data
    [[ "${__value}" =~ ^([^:]+):([0-9]+):(.*) ]]
    __elements[${BASH_REMATCH[1]}]=${BASH_REMATCH[2]}
  done < "${STORE_PATH}"

  # print everything
  for __key in "${!__elements[@]}"; do

    # remove expired items
    __ttl=${__elements[${__key}]}
    (( __ttl > 0 )) && (( __datetime > __ttl )) && continue

    echo "${__key} (${__ttl})"
  done
}

#.--
#.1 Check for a key in the store
#.2 (key){the key to lookup in the store}
#.3H Look in the store if a key is present or not. !!
#.3H This is an alias to kvstore::get.
#.3F This function returns True (0) if the key is present, False (1) otherwise.
#.4 Check for key 'my_string'
#.4 $ kvstore::is_exist 'my_string'
#.--
kvstore::is_exist() {
  kvstore::get "$1" >/dev/null 2>&1
  return $?
}
