#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Functions to ease GIT interaction

#----- public functions

#.--
#.1 Retrieve the GIT repository name
#.3H The repository name is taken from the remore URL. !!
#.3H The function uses the current directory as GIT repository.
#.4 Retrieve the repository name from the local directory
#.4 $ git::repo_name
#.--
git::repo_name() {
  # shellcheck disable=SC2155
  local __temp=$(basename "$(git::repo_url)")
  echo "${__temp%.git}"
}

#.--
#.1 Retrieve the GIT repository URL
#.3H The URL is taken from the remote 'origin'.
#.3H The function uses the current directory as GIT repository.
#.4 Retrieve the repository URL
#.4 $ git::repo_url
#.--
git::repo_url() {
  git ls-remote --get-url origin
}

#.--
#.1 Retrieve the local directory
#.3H Return the absolute location of the current GIT local directory.
#.4 Retrieve the local directory
#.4 $ git::local_dir
#.--
git::local_dir() {
  git rev-parse --show-toplevel
}

#.--
#.1 Retrieve the SHA1 of the last commit
#.3H Returns the SHA1 of the last commit from the current branch.
#.3F The function returns the full SHA1. !!
#.3F See \fBlast_commit_sha1_short\fR for a shorter SHA1.
#.4 Retrieve the last SHA1
#.4 $ git::last_commit_sha1
#.--
git::last_commit_sha1() {
  git rev-parse HEAD
}

#.--
#.1 Retrieve the SHA1 of the last commit
#.3H Returns the SHA1 of the last commit from the current branch.
#.3F The function returns the short SHA1. !!
#.3F See \fBlast_commit_sha1\fR for a full SHA1.
#.4 Retrieve the last SHA1
#.4 $ git::last_commit_sha1_short
#.--
git::last_commit_sha1_short() {
  git rev-parse --short HEAD
}

#.--
#.1 Retrieve the current active branch
#.3H Returns the name of the active branch.
#.4 Retrieve the current branch
#.4 $ git::active_branch
#.--
git::active_branch() {
  git rev-parse --abbrev-ref HEAD
}

#.--
#.1 Check if we are in GIT work tree
#.3H Check if the current directory is effectively a work tree.
#.3F Returns True (0) if we are inside a GIT work tree, False (!0) otherwise.
#.4 Check if we are inside a work tree
#.4 $ git::is_working_tree
#.--
git::is_working_tree() {
  git rev-parse --is-inside-work-tree >/dev/null 2>&1
}