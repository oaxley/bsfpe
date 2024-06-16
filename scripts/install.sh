#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Install script for BSFPE library

#----- globals
SCRIPT_DIR=$(dirname "${BASH_SOURCE}")
SCRIPT_DIR=$(realpath "${SCRIPT_DIR}")

INSTALL_DIR=${INSTALL_DIR:-${HOME}}
BSFPE_DIR=$(realpath ${INSTALL_DIR}/bsfpe)


#----- begin
echo "BSFPE - Bash Scripts for Production Environment"
echo ""
echo -e "Install directory: \033[1m ${BSFPE_DIR}\033[0m"
echo "(install directory can be changed with INSTALL_DIR envvar)"

echo ""
echo "Do you want to proceed? (Y/N)"
read -r answer
[[ "${answer}" != "y" && "${answer}" != "Y" ]] && exit

# create the target directory
mkdir -p "${BSFPE_DIR}"

# copy everything under distrib
cp -R ${SCRIPT_DIR}/../distrib/* "${BSFPE_DIR}"

# footer
echo ""
echo "Installed."
echo "To load the library in your environment, do:"
echo "    $ source ${BSFPE_DIR}/loader.sh"
echo ""

