#!/bin/bash

# load shell library
# shellcheck disable=SC1091
source "${BSFPE_LIBRARY_DIR}/loader.sh"

#----- globals

# retrieve the script directory
SCRIPT_NAME=$(basename "$0")
SCRIPT_DIR=$(dirname "$0")
if [[ "${SCRIPT_DIR}" == "." ]]; then
  SCRIPT_DIR=$(pwd)
fi

FULL_WEEK="no"
KEEP_DATA="no"


#----- functions
help() {
  echo "${SCRIPT_NAME} - daily logs rotation"
  echo "Syntax:"
  echo "   ${SCRIPT_NAME} [-h|--help] [-f|--full] [-k|--keep] <path>"
  echo ""
  echo "-h|--help : this help."
  echo "-f|--full : use a 7-days week instead of a business week of 5 days."
  echo "-k|--keep : keep the content of today's directory (default: purge)."
  echo
  exit
}

# create directory structure
create_directories() {
  # create structure
  mkdir -p {Mon,Tue,Wed,Thu,Fri}
  [[ "${FULL_WEEK}" == "yes" ]] && mkdir -p {Sat,Sun}

  # remove previous links
  rm -f today yesterday
}

# create today's link
create_today() {
  local __weekday="$1"
  ln -sf "${__weekday:0:3}" "today"

  # empty directory if needed
  if [[ "${KEEP_DATA}" == "no" ]]; then
    logger::info "Removing old files from 'today'"
    rm -f today/*
  else
    logger::info "Keeping old files in 'today'"
  fi
}

# create yesterday's link
create_yesterday() {
  local __today="$1"
  local __yesterday=$(date::yesterday)

  # take care of the 5-days week where yesterday=Fri if today=Mon
  if [[ "${__today:0:3}" == "Mon" && "${FULL_WEEK}" == "no" ]]; then
    __yesterday=$(date::sub_days 2 "${__yesterday}")
  fi

  # create the link
  local __day=$(date::weekday "${__yesterday}")
  ln -s "${__day:0:3}" "yesterday"
}


#----- begin

# parse command line arguments
while (( $# > 0 )); do
  case "$1" in
    "-h"|"--help")
      help
      ;;
    "-f"|"--full")
      FULL_WEEK="yes"
      shift
      ;;
    "-k"|"--keep")
      KEEP_DATA="yes"
      shift
      ;;
    *)
      LOG_PATH="$1"
      shift
      ;;
  esac
done

# create the target directory
mkdir -p "${LOG_PATH}" 2>/dev/null
if (( $? > 0 )); then
  logger::error "Unable to create directory ${LOG_PATH}"
  exit 1
fi

# ensure we are in the correct directory before starting
system::pushd "${LOG_PATH}"
create_directories

logger::info "Creating 'today' and 'yesterday' links"
__weekday=$(date::weekday)
create_today "${__weekday}"
create_yesterday "${__weekday}"

# go back to the caller directory
system::popd
logger::info "Operation completed."