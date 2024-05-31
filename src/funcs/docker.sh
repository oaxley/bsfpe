#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Functions for docker images/containers management

#----- guards
JQ_BIN=$(which jq)
[[ -z ${JQ_BIN} || ! -x ${JQ_BIN} ]] && return

DK_BIN=$(which docker)
[[ -z ${DK_BIN} || ! -x ${DK_BIN} ]] && return

#----- private functions
# retrieve the container information as json
docker::_inspect() {
  docker inspect --type container $1
}

#----- public functions

# retrieve the logpath for a container
docker::log_path() {
  docker::_inspect $1 | jq -r '.[].LogPath'
}

# retrieve the name of the container
docker::get_name() {
  docker::_inspect $1 | jq -r '.[].Name' | cut -c2-
}

# retrieve the ID of a container
docker::get_id() {
  docker::_inspect $1 | jq -r '.[].Id'
}

# retrieve the SHA256 base Image of a container
docker::base_image() {
  docker::_inspect $1 | jq -r '.[].Image' | cut -d: -f2
}

# retrieve the short version of the SHA256
docker::base_image_short() {
  local __image=$(docker::base_image $1)
  echo ${__image} | cut -c-12
}

# retrieve the tag of a particular image
docker::image_tag() {
  docker inspect --type image $1 | jq -r '.[].RepoTags[0]'
}

# retrieve the image name
docker::image_name() {
  local __image_tag=$(docker::image_tag $1)
  echo ${__image_tag} | cut -d: -f1
}

# retrieve the image version
docker::image_version() {
  local __image_tag=$(docker::image_tag $1)
  echo ${__image_tag} | cut -d: -f2
}

# retrieve the image size
docker::image_size() {
  docker inspect --type image $1 | jq -r '.[].Size'
}