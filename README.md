# Bash Scripts for Production Environment (BSFPE)

![Bash Script](https://img.shields.io/badge/bash_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)

## Purpose

This library contains Bash functions to help in the development of scripts. 
For the most part, they have been used in production environments for years.  
They are listed here for reference and inspiration (and without any guarantee) in case it might be of help.  

The library has been developed mainly for the Linux environment. No support is provided for other OS.

## Installation

By default, the installation is done in `${HOME}/.bsfpe`.
To install the library under another location, set the environment variable `INSTALL_DIR` before 
executing the installation.

### Manpages

The code is auto-documented to allow the creation of manpages from it. By default, manpages are not
generated during installation.  

If you wish to have them installed:

``` bash
$ make manpages
```

### Installation

1. With `make`

A Makefile is present at the root directory. To install the library with make:

``` bash
$ make install
```

2. With the installer script

An alternate way for installation is with the `install.sh` script present in the `scripts` directory
of the library.

``` bash
$ cd scripts && ./install.sh
```

### Post Installation

Once the library is installed, add the following export in your `.bashrc` file:

``` bash
# export the location of the library
export BSFPE_LIBRARY_DIR="${HOME}/.bsfpe"
```

The manpages will be installed in `${HOME}/.bsfpe/man/man1` so you need to add this directory to
the environment variable `MANPATH` to access them.

``` bash
# add manpages
$ export MANPATH=${MANPATH}:${HOME}/.bsfpe/man

# get manpages for date::is_leap
$ man bsfpe_date_is_leap
```

## Docker container

To test the library in a secure environment, a Dockerfile is present in the `docker` directory.  

``` bash
# build the container
$ make docker-build

# run an interactive session into it
$ make docker-run
```

## Examples

Some usage examples are available in the directory `examples`.

## License

All the sources and files are under the [MIT License](https://choosealicense.com/licenses/mit/).