#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Functions to ease GIT interaction

#----- guards
GIT_BIN=$(which git)
[[ -z ${GIT_BIN} || ! -x ${GIT_BIN} ]] && return


#----- public

# retrieve the GIT repository name
git::repo_name() {
  local __temp=$(basename $(git::repo_url))
  echo ${__temp%.git}
}

# retrieve the GIT repository URL
git::repo_url() {
  git ls-remote --get-url origin
}

# return the absolute location of the current GIT local directory
git::local_dir() {
  git rev-parse --show-toplevel
}

# return the full SHA1 of the latest commit (HEAD)
git::last_commit_sha1() {
  git rev-parse HEAD
}

# return the short SHA1 of the latest commit (HEAD)
git::last_commit_sha1_short() {
  git rev-parse --short HEAD
}

# return the current active branch
git::active_branch() {
  git rev-parse --abbrev-ref HEAD
}

# check if we are inside a GIT working tree
# return:
#   0 if we are inside a GIT work tree, !=0 otherwise
git::is_working_tree() {
  git rev-parse --is-inside-work-tree >/dev/null 2>&1
}