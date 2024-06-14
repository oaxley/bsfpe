#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT license
#
# @brief    Docker Container specific functions

#----- public functions
# retrieve the logpath for a container
docker::log_path() {
  docker inspect --type container "$1" | jq -r '.[].LogPath'
}

# retrieve the name of the container
docker::get_name() {
  docker inspect --type container "$1" | jq -r '.[].Name' | cut -c2-
}

# retrieve the ID of a container
docker::get_id() {
  docker inspect --type container "$1" | jq -r '.[].Id'
}

# retrieve the SHA256 base Image of a container
docker::image_id() {
  docker inspect --type container "$1" | jq -r '.[].Image' | cut -d: -f2
}

# retrieve the short version of the SHA256
docker::image_id_short() {
  # shellcheck disable=SC2155
  local __image=$(docker::image_id "$1")
  echo "${__image}" | cut -c-12
}

