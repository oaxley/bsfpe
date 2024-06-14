#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT license
#
# @brief    Docker Container specific functions

#----- public functions
# retrieve the tag of a particular image
docker::image_tag() {
  docker inspect --type image "$1" | jq -r '.[].RepoTags[0]'
}

# retrieve the image name
docker::image_name() {
  # shellcheck disable=SC2155
  local __image_tag=$(docker::image_tag "$1")
  echo "${__image_tag}" | cut -d: -f1
}

# retrieve the image version
docker::image_version() {
  # shellcheck disable=SC2155
  local __image_tag=$(docker::image_tag "$1")
  echo "${__image_tag}" | cut -d: -f2
}

# retrieve the image size
docker::image_size() {
  docker inspect --type image "$1" | jq -r '.[].Size'
}