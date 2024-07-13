#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT license
#
# @brief    Docker Container specific functions

#----- public functions

#.--
#.1 Retrieve the tag of an image
#.2 (image_id){The ID of an image}
#.3H Retrieve the full tag of the docker image.
#.4 Retrieve the tag of image
#.4 $ docker::image_tag 6e38f40d628d
#.--
docker::image_tag() {
  docker inspect --type image "$1" | jq -r '.[].RepoTags[0]'
}

#.--
#.1 Retrieve the name of an image
#.2 (image_id){The ID of an image}
#.3H Retrieve the name of the docker image.
#.4 Retrieve the name of an image
#.4 $ docker::image_name 6e38f40d628d
#.--
docker::image_name() {
  # shellcheck disable=SC2155
  local __image_tag=$(docker::image_tag "$1")
  echo "${__image_tag}" | cut -d: -f1
}

#.--
#.1 Retrieve the version of an image
#.2 (image_id){The ID of an image}
#.3H Retrieve the version of the docker image.
#.4 Retrieve the version of an image
#.4 $ docker::image_version 6e38f40d628d
#.--
docker::image_version() {
  # shellcheck disable=SC2155
  local __image_tag=$(docker::image_tag "$1")
  echo "${__image_tag}" | cut -d: -f2
}

#.--
#.1 Retrieve the size of an image
#.2 (image_id){The ID of an image}
#.3H Retrieve the size in Bytes of the docker image.
#.4 Retrieve the size of an image
#.4 $ docker::image_size 6e38f40d628d
#.--
docker::image_size() {
  docker inspect --type image "$1" | jq -r '.[].Size'
}