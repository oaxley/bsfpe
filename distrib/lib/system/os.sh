#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    OS determination functions

#----- public functions
#.--
#.1 Return the OS name
#.3H This function returns the OS name as returned by the \fBuname\fR command.
#.--
system::os_name() {
  uname -s
}

#.--
#.1 Return the OS version
#.3H This function returns the OS version as returned by the \fBuname\fR command.
#.--
system::os_version() {
  uname -r
}

#.--
#.1 Return the current user id
#.3H This function returns the ID number of the user
#.--
system::user_id() {
  id -u
}

#.--
#.1 Return the current group id
#.3H This function returns the ID number of the user group
#.--
system::user_group() {
  id -g
}

#.--
#.1 Return the current user name
#.3H This function returns the name of the user
#.--
system::user_name() {
  id -un
}

#.--
#.1 Return the current group name
#.3H This function returns the name of the user group
#.--
system::user_group_name() {
  id -gn
}

#.--
#.1 Return all the groups ID the user belongs to
#.3H This function returns all the IDs from the groups the user is member of
#.3F The groups are separated by a comma ','
#.--
system::user_groups() {
  id -G | tr " " ","
}

#.--
#.1 Return all the groups name the user belongs to
#.3H This function returns all the names from the groups the user is member of
#.3F The groups are separated by a comma ','
#.--
system::user_groups_name() {
  id -Gn | tr " " ","
}

#.--
#.1 Check if a group is present
#.2 (name|id){Name or ID of the group to check}
#.3H This function checks in /etc/group that a particular group exist.
#.3F The function will return True (0) if the group is present, False (1) otherwise
#.4 Look up for the group 'video'
#.4 $ system::is_group "video"
#.--
system::is_group() {
  # an ID
  if [[ $1 =~ ^[0-9]+$ ]]; then
    grep ":$1:" /etc/group >/dev/null 2>&1
  else
    grep "^$1:" /etc/group >/dev/null 2>&1
  fi

  return $?
}

#.--
#.1 Returns the ID of a group
#.2 (name){Name of the group to retrieve}
#.3H This function checks in /etc/group that a particular group exist.
#.3F The function will return True (0) if the group is present, False (1) otherwise
#.4 Look up for the group 'video'
#.4 $ system::get_group_id "video"
#.--
system::get_group_id() {
  grep "$1" /etc/group | cut -d: -f3
}

#.--
#.1 Returns the Name of a group
#.2 (ID){ID of the group to retrieve}
#.3H This function checks in /etc/group that a particular group exist.
#.3F The function will return True (0) if the group is present, False (1) otherwise
#.4 Look up for the group '44'
#.4 $ system::get_group_name 44
#.--
system::get_group_name() {
  grep "x:${1}:" /etc/group | cut -d: -f1
}


#.--
#.1 Check if a user is present
#.2 (name|id){Name or ID of the user to check}
#.3H This function checks in /etc/passwd that a particular user exist.
#.3F The function will return True (0) if the user is present, False (1) otherwise
#.4 Look up for the user 'games'
#.4 $ system::is_user "games"
#.--
system::is_user() {
  # an ID
  if [[ $1 =~ ^[0-9]+$ ]]; then
    grep "x:$1:" /etc/passwd >/dev/null 2>&1
  else
    grep "^$1:" /etc/passwd >/dev/null 2>&1
  fi

  return $?
}

#.--
#.1 Return the ID of a user
#.2 (name){Name of the user to check}
#.3H This function checks in /etc/passwd that a particular user exist.
#.3F The function will return True (0) if the user is present, False (1) otherwise
#.4 Look up for the user 'games'
#.4 $ system::get_user_id "games"
#.--
system::get_user_id() {
  grep "^${1}:" /etc/passwd | cut -d: -f3
}

#.--
#.1 Return the name of a user
#.2 (ID){ID of the user to check}
#.3H This function checks in /etc/passwd that a particular user exist.
#.3F The function will return True (0) if the user is present, False (1) otherwise
#.4 Look up for the user '5'
#.4 $ system::get_user_name 5
#.--
system::get_user_name() {
  grep "x:${1}:" /etc/passwd | cut -d: -f1
}
