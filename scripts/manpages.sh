#!/bin/bash

#----- globals
SCRIPT_NAME=$(basename ${BASH_SOURCE})
SCRIPT_DIR=$(dirname ${BASH_SOURCE})

# $1 => directory to look for functions
SOURCE_DIR="$1"
TARGET_DIR=$( realpath ${SCRIPT_DIR}/../distrib/man/man1 )

TMP_DIR=/tmp/${SCRIPT_NAME%.sh}.$$


#----- functions
_pushd() {
  pushd "$1" >/dev/null 2>&1 || exit
}

_popd() {
  popd >/dev/null 2>&1 || exit
}

processFunction() {
  local __count=${#__array[@]}

  # only fully documented functions
  (( __count == 1 )) && return

  # save function name for later
  echo "${__array[$(( __count - 1 ))]}" >> "${TMP_DIR}/see_also"
  for I in "${__array[@]}"; do
    echo "$I" >> "${TMP_DIR}/functions"
  done
  echo "#---" >> "${TMP_DIR}/functions"
}

writeHeader() {
  echo ".TH ${1} 1 \"June 2024\" \"1.0.0\" \"BSFPE\"" >> "${TMP_DIR}/output"
}

writeName() {
  local __name=$1; shift
  echo ".SH NAME" >> "${TMP_DIR}/output"
  echo {"\fB${__name}\fR \-","$@"}  >> "${TMP_DIR}/output"
}

writeSynopsis() {
  local __name=$1; shift
  local __values=("$@")

  { echo ".SH SYNOPSIS"; echo ".B ${__name}"; } >> "${TMP_DIR}/output"

  for I in "${__values[@]}"; do
    __value=$(echo "$I" | cut -d'|' -f1)
    echo ".IR ${__value}" >> "${TMP_DIR}/output"
  done
}

writeDesc() {
  local __values=("$@")
  echo ".SH DESCRIPTION" >> "${TMP_DIR}/output"
  for I in "${__values[@]}"; do
    echo "${I}" >> "${TMP_DIR}/output"
  done
}

writeExample() {
  local __values=("$@")
  echo ".SH EXAMPLES" >> "${TMP_DIR}/output"
  for I in "${__values[@]}"; do
    if [[ "${I}" =~ ^\$ ]]; then
      { echo ".RS"; echo "${I}"; echo ".RE"; } >> "${TMP_DIR}/output"
    else
      echo "${I}" >> "${TMP_DIR}/output"
    fi
    echo "" >> "${TMP_DIR}/output"
  done
}

writeSeeAlso() {
  local __name="$1"; shift
  local __flag=0

  echo ".SH \"SEE ALSO\"" >> "${TMP_DIR}/output"
  while read -r LINE; do
    [[ "${LINE}" == "${__name}" ]] && continue

    (( __flag > 0 )) && echo -n ", " >> "${TMP_DIR}/output"
    echo -n "${LINE}(1)" >> "${TMP_DIR}/output"
    __flag=1
  done < "${TMP_DIR}/see_also"
}

processFile() {
  local __name
  local __short_description
  local __long_description
  local __synopsis
  local __examples

  __name=""
  __short_description=""
  __long_description=()
  __synopsis=()
  __examples=()

  # nothing to be done
  [[ ! -e ${TMP_DIR}/functions ]] && return

  while read -r LINE; do

    if [[ "${LINE}" =~ "#---" ]]; then
      writeHeader "${__name}"
      writeName "${__name}" "${__short_description}"
      writeSynopsis "${__name}" "${__synopsis[@]}"

      if (( ${#__long_description} == 0 )); then
        writeDesc "${__short_description}"
      else
        writeDesc "${__long_description[@]}"
      fi

      if (( ${#__examples[@]} > 0 )); then
        writeExample "${__examples[@]}"
      fi

      writeSeeAlso "${__name}"


      # move the file to its destination
      __filename="bsfpe_${__name/::/_}.1"
      mv "${TMP_DIR}/output" "${TARGET_DIR}/${__filename}"

      # purge data
      __name=""
      __short_description=""
      __long_description=()
      __synopsis=()
      __examples=()

      # next line
      continue
    fi

    if [[ "${LINE}" =~ ^#.1 ]]; then
      __short_description=$(echo "${LINE}" | cut -d' ' -f2-)
      continue
    fi

    if [[ "${LINE}" =~ ^#.2 ]]; then
      __tmp=$(echo "${LINE}" | cut -d' ' -f2-)
      __synopsis+=("${__tmp}")
      continue
    fi

    if [[ "${LINE}" =~ ^#.3 ]]; then
      __tmp=$(echo "${LINE}" | cut -d' ' -f2-)
      __long_description+=("${__tmp}")
      continue
    fi

    if [[ "${LINE}" =~ ^#.4 ]]; then
      __tmp=$(echo "${LINE}" | cut -d' ' -f2-)
      __examples+=("${__tmp}")
      continue
    fi

    # default line is the name
    __name=${LINE}

  done < "${TMP_DIR}/functions"
}

#----- begin

[[ -z "${SOURCE_DIR}" ]] && exit 1

# create the target dir
mkdir -p "${TARGET_DIR}"
mkdir -p "${TMP_DIR}"

_pushd "${SOURCE_DIR}"

for FILE in *.sh; do
  # init should not be considered
  [[ "${FILE}" == "__init.sh" ]] && continue

  # remove the previous see_also
  rm -f "${TMP_DIR}/see_also"
  rm -f "${TMP_DIR}/functions"

  # mainloop
  __save=0
  __array=()
  while read -r LINE
  do
    # toggle
    if [[ "${LINE}" == "#.--" ]]; then
      __save=$(( ( __save + 1 ) & 1 ))
      continue
    fi

    if (( __save == 1 )); then
      __array+=("${LINE}")
    fi

    if [[ "${LINE}" =~ ^[a-z]+::[a-z]+ ]]; then
      __function=$(echo "${LINE}" | cut -d'(' -f1)
      __array+=("${__function}")
      processFunction
      __array=()
    fi
  done < "${FILE}"

  # process this file
  processFile
done

_popd

# remove temporary files
rm -rf "${TMP_DIR}"
