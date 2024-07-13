#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT license
#
# @brief    Docker Container specific functions

#----- public functions

#.--
#.1 Retrieve the log path of the container
#.2 (container){The name or ID of the docker container}
#.3H Retrieve the log path of the container.
#.4 Retrieve the log of container 'magical_wand'
#.4 $ docker::log_path magical_wand
#.4 Retrieve the log of contaner '0997655add3d'
#.4 $ docker::log_path 0997655add3d
#.--
docker::log_path() {
  docker inspect --type container "$1" | jq -r '.[].LogPath'
}

#.--
#.1 Retrieve the name of the container
#.2 (container_id){The ID of the docker container}
#.3H Retrieve the name of the docker container from its ID.
#.4 Retrieve the name of contaner '0997655add3d'
#.4 $ docker::get_name 0997655add3d
#.--
docker::get_name() {
  docker inspect --type container "$1" | jq -r '.[].Name' | cut -c2-
}

#.--
#.1 Retrieve the ID of the container
#.2 (container){The name of the docker container}
#.3H Retrieve the ID of the docker container from its name.
#.4 Retrieve the ID of contaner 'magical_wand'
#.4 $ docker::get_id magical_wand
#.--
docker::get_id() {
  docker inspect --type container "$1" | jq -r '.[].Id'
}

#.--
#.1 Retrieve the SHA256 of the container
#.2 (container){The ID or name of the docker container}
#.3H Retrieve the image ID of the docker container.
#.3F This function returns the full SHA256 of the image. !!
#.3F See \fBdocker::image_id_short\fR for the short SHA256.
#.4 Retrieve the image ID of contaner 'magical_wand'
#.4 $ docker::image_id magical_wand
#.--
docker::image_id() {
  docker inspect --type container "$1" | jq -r '.[].Image' | cut -d: -f2
}

#.--
#.1 Retrieve the SHA256 (short) of the container
#.2 (container){The ID or name of the docker container}
#.3H Retrieve the image ID of the docker container.
#.3F This function returns the short SHA256 (12 chars) of the image. !!
#.3F See \fBdocker::image_id\fR for the full SHA256.
#.4 Retrieve the image ID of contaner 'magical_wand'
#.4 $ docker::image_id_short magical_wand
#.--
docker::image_id_short() {
  # shellcheck disable=SC2155
  local __image=$(docker::image_id "$1")
  echo "${__image}" | cut -c-12
}

