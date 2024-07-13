#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Bash Wrapper around the KVStore scripts

#----- functions
kvstore::main() {
  # shellcheck disable=SC1091
  . "${BSFPE_LIBRARY_DIR}/lib/kvstore/kvstore.sh" "$@"
}

#.--
#.1 Create a new key/value pair
#.2 (key){key to insert.}
#.2 (value|@TTL){value to associate with the key, or TTL to set.}
#.3H Insert a new key/value pair or add a TTL to an existing key. !!
#.3H In its first form, a new value is inserted in the store and associated with the key. !!
#.3H When the value starts with '@', set a Time To Live (TTL) to an existing key.
#.3H The TTL is expressed in seconds.
#.3F Keys those TTL has elapsed are non longer available. Keys with a TTL of 0 (default) do not expire.
#.4 Create a new key 'my_string' in the store
#.4 $ kvstore::set my_string "Hello, World!"
#.4 Add a TTL of 5 minutes (300 seconds) to the key 'my_string'
#.4 $ kvstore::set my_string @300
#.--
kvstore::set() {
  # shellcheck disable=SC1091
  . "${BSFPE_LIBRARY_DIR}/lib/kvstore/kvstore.sh" set "$@"
}

#.--
#.1 Get the value associated with a key
#.2 (key){key to lookup in the store.}
#.3H Only keys which did not expire can be retrieved.
#.4 Retrieve the value associated with 'my_string'
#.4 $ kvstore::get my_string
#.--
kvstore::get() {
  # shellcheck disable=SC1091
  . "${BSFPE_LIBRARY_DIR}/lib/kvstore/kvstore.sh" get "$@"
}

#.--
#.1 Remove a key from the store
#.2 (key){key to lookup in the store.}
#.3F Once the key has been deleted, it cannot be retrieved.
#.4 Delete the key 'my_string' from the store
#.4 $ kvstore::del my_string
#.--
kvstore::del() {
  # shellcheck disable=SC1091
  . "${BSFPE_LIBRARY_DIR}/lib/kvstore/kvstore.sh" del "$@"
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
  # shellcheck disable=SC1091
  . "${BSFPE_LIBRARY_DIR}/lib/kvstore/kvstore.sh" clean "$@"
}

#.--
#.1 Print the keys available in the store
#.3H This command will print all the available keys and their corresponding TTL (if any).
#.3H It is mainly a debug command for scripts.
#.4 Print the keys available in the store
#.4 $ kvstore::print
#.--
kvstore::print() {
  # shellcheck disable=SC1091
  . "${BSFPE_LIBRARY_DIR}/lib/kvstore/kvstore.sh" print "$@"
}
