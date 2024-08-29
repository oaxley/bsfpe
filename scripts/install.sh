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
echo "Add the following line to your .bashrc:"
echo "export BSFPE_LIBRARY_DIR=\"${BSFPE_DIR}\""
echo ""
echo "To load the library in your current environment (or in scripts), do:"
echo "    $ source \${BSFPE_LIBRARY_DIR}/loader.sh"
echo ""

