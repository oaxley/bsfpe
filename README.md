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

The manpages will be installed in `${BSFPE_LIBRARY_DIR}/man/man1` so you need to add this directory to
the environment variable `MANPATH` to access them.

``` bash
# add manpages
$ export MANPATH=${MANPATH}:${BSFPE_LIBRARY_DIR}/man

# get manpages for date::is_leap
$ man bsfpe_date_is_leap
```

## Functions

Here is a list of available functions.

### The core functions

#### Date manipulation with `date::` / `datetime::`

- Functions to convert a datetime from and to Epoch.

```
datetime::to_epoch(), datetime::from_epoch()
```

- Functions to retrieve the day or month name

```
date::weekday(), date::month_name()
``` 

- Functions to retrieve constituents from a datetime

```
date::year(), date::month(), date::day(), date::date()
```

- Date arithmetics

```
date::add_days(), date::sub_days(), date::today(), date::tomorrow(), date::yesterday()
```
- Function for leap year `date::is_leap()`

#### Time manipulation `time::`

- Retrieve current time / format time

```
time::time(), time::now()
```

- Extract time information

```
time::hours(), time::minutes(), time::seconds()
```

- time arithmetics
```
time::add_hours(), time::sub_hours()
```

#### Process execution `execute::`

- Functions for returning constant status
```
execute::true(), execute::false()
```
- Functions to execute in directory or wait for a timer to elapse
```
execute::run_in(), execute::wait_until()
```

#### Logging facilities `logger::`

```
logger::set_log_level(), 
logger::debug(), logger::info(), logger::warning(), logger::error(), logger::critical()
```

#### Basic mathematics functions `maths::`

- Adding, clearing and counting values
```
maths::append(), maths::clear(), maths::length()
```

- Minimum, maximum, sum
```
maths::minimum(), maths::maximum(), maths::sum()
```

- Average, median, variance and standard deviation
```
maths::average(), maths::median()
maths::variance(), maths::stddev()
```

- Percentiles `maths::percentile()`

#### Random numbers generators `rand::`

- Generate random numbers of 8, 16, 24, or 32 bits

```
random::rand8(), random::rand16(), 
random::rand24(), random::rand32()

```

#### Strings manipulation `strings::`

- Remove blanks at the beginning, end or both

```
strings::ltrim(), strings::rtrim; strings::trim()
```

- Strings length `strings::length()`

- Upper/lower case conversion

```
strings::to_upper(), strings::to_lower()
```

- Characters extraction
```
strings::left(), strings::right(), strings::mid()
```

### Configuration parsers

- INI, TOML and YAML configuration key/value extraction

```
config::ini(), config::toml(), config::yaml()
```

### Docker container/image manipulation

#### Container manipulation 

- Retrieve container log path `docker::log_path()`
- Retrieve the name / ID of the container
```
docker::get_name(), docker::get_id()
```

- Container image id
```
docker::image_id(), docker::image_id_short()
```

#### Image manipulation

- Image tag `docker::image_tag`
- Image name and version
```
docker::image_name(), docker::image_version()
```
- Image size `docker::image_size()`

### Git manipulation

- Git repository name and URL
```
git::repo_name(), git::repo_url()
```

- Local directory `git::local_dir()`
- Last commit sha1
```
git::last_commit_sha1(), git::last_commit_sha1_short()
```
- Active branch `git::active_branch()`
- Git worktree `git::is_working_tree()`

### Key/Value store

- Set a new value or TTL `kvstore::set()`
- Get a value associated with a key `kvstore::get()`
- Remove a key `kvstore::del()`
- Clean the key store `kvstore::clean()`
- Print available keys `kvstore::print()`
- Check if a key exists `kvstore::is_exist()`


### Network 

- Retrieve MAC & IP addresses
```
network::mac_address(), network::ip_address()
```

- Host ID, hostname and FQDN
```
network::hostid(), network::fqdn(), network::hostname()
```
- Test if a connection is opened `network::zero_connect()`
- Create a TCP listener `network::fake_server()`
- Multicast receiver/publisher
```
network::mcast_recv(), network::mcast_pub()
```

### System

#### User management

- Get user name and ID, group name and ID
```
system::user_name(), system::user_id(), 
system::user_group_name(), system::user_group_id()
```
- Get all the groups name/id for a user
```
system::user_groups_name(), system::user_groups_id()
```
- Check if a group / user exist 
```
system::is_group(), system::is_user()
```
- Get a group name / id
```
system::get_group_name(), system::get_group_id()
```
- Get a user name / id
```
system::get_user_name(), system::get_user_id()
```

#### OS management

- Get the OS name and version
```
system::os_name(), system::os_version()
```

#### CPU management

- Get the CPU type, count and check for flags
```
system::cpu_type(), system::cpu_count(), 
system::is_cpu_flag()
```

#### Patches 

- Create, apply and revert a patch
```
system::patch_create(), system::patch_apply(), 
system::patch_revert()
```
#### Files management

- Get last access time `system::file_access_time()`
- File size `system::file_size()`
- File permissions `system::file_perms()`
- Compare 2 files `system::file_compare()`
- Push / Pop directory
```
system::pushd(), system::popd()
```
- Files count in a directory `system::num_files()`

#### Miscellaneous

#### Lock management `lock::`

- Acquire a lock `lock::acquire()`
- Release a lock `lock::release()`

#### Formatter `format::`

- Format size to human readable `format::size()`

#### UUID `uuid::`

- Generate UUID v4 `uuid::uuidv4()`

#### LIFO Stack `stack::`

- Stack size `stack::count()`
- Print the stack `stack::print()`
- Push and Pop element
```
stack::push(), stack::pop()
```
- Read the top value `stack::top()`
- Duplicate and drop
```
stack::dup(), stack::drop()
```
- Swap and rotate values
```
stack::swap(), stack::rotate()
```
- Clear the stack `stack::clear()`

## Usage

Adding the library into your environment, or inside a script requires only to source the `loader.sh`
script.

``` bash
# load the library into the environment
$ source ${BSFPE_LIBRARY_DIR}/loader.sh
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