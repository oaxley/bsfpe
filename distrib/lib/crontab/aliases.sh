#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Aliases definition for Crontab

# crontab edition
alias cre="crontab -e"

# list all entries in the crontab
alias crl="crontab -l"

# get a specific entry in the crontab
alias crg="crontab -l | egrep -v '^#|^$' | grep -i"

# list all entries, sorted by hours then minutes
alias crs="crontab -l | egrep -v '^#|^$' | sort -n -k2 -k1"
