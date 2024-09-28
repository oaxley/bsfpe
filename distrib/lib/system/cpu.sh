#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    CPU info (Linux specific)

#----- guards
# do not load if the file does not exist on the system
[[ ! -e /proc/cpuinfo ]] && return

#----- public functions

#.--
#.1 Return the current CPU type
#.3H Return the current CPU type as set in the \fB/proc/cpuinfo\fR file.
#.--
system::cpu_type() {
  grep 'model name' /proc/cpuinfo | tail -1 | cut -d: -f2
}

#.--
#.1 Return the number of CPU
#.3H Return the number of CPU on this machine as set in the \fB/proc/cpuinfo\fR file.
#.--
system::cpu_count() {
  grep -c 'processor' /proc/cpuinfo
}

#.--
#.1 Check is a CPU flag is present
#.2 (flag){The name of the flag}
#.3H This function looks into \fB/proc/cpuinfo\fR in the \fBflags\fR section.
#.3F It returns True (0) if the flag is found, False (1) otherwise.
#.4 Check for the 'avx' flag
#.4 $ system::cpu_flag avx
#.4 Check for the 'cpuid' flag
#.4 $ system::cpu_flag cpuid
#.--
system::is_cpu_flag() {
  grep 'flags' /proc/cpuinfo | head -1 | xargs -n 1 | grep "^$1$" >/dev/null
  return $?
}
