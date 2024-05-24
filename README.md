# Bash Scripts for Production Environment (BSFPE)

## Purpose

This repository contains a suite of scripts and functions in Python or Bash that I developed along
the years and extensively used in production environment.  

## Description

### Functions

`logger.sh`
> print information in a standard and cohesive way accross scripts

`network.sh`
> utilities to help with network tasks and troubleshoot  

`random.sh`
> functions to help with random number generation in scripts  

`system.sh`
> basic system functions

`uuid.sh`
> generate random UUID numbers

### Scripts

`config`
> INI, TOML and YAML configuration parser and key lookup  

`mcast`
> scripts for listening & publishing multicast packets with record/replay capabilities  

`kvstore`
> simple Key/Value store for scripts  

## Usage

From your `.bashrc` or `.bash_profile` scripts, execute the loader:

``` bash
source ~/.bsfpe/loader.sh
```

## License

All the sources and files are under the [MIT License](https://choosealicense.com/licenses/mit/).