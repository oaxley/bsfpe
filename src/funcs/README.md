# Funcs

This directory holds only Bash functions (typically only few lines)

## Functions definition

### Random package (`random::`)

| function | description |
| --- | --- |
| `rand8` | return a random value between 0 and 255 |
| `rand16` | return a random value between 0 and 65,535 |
| `rand24` | return a random value between 0 and 16,777,215 |
| `rand32` | return a random value between 0 and 4,294,967,295 |

### UUID package (`uuid::`)

| function | description |
| --- | --- |
| `uuid4` | return a UUID v4 string |

### Network package (`network::`)

| function | description |
| --- | --- |
| `fake_server` | create a TCP listener to check FW ports |
| `zero_connect` | test if a port is opened |
| `mac_address` | retrieve the MAC address of an interface |
| `ip_address` | retrieve the IP address of an interface |

### Logger package (`logger::`)

| function | description |
| --- | --- |
| `setLogLevel` | set the current log level (default: INFO) |
| `debug` | print a message with the DEBUG log level |
| `info` | print a message with the INFO log level |
| `warning` | print a message with the WARNING log level |
| `error` | print a message with the ERROR log level |
| `critical` | print a message with the CRITICAL log level |

### System package (`system::`)

| function | description |
| --- | --- |
| `file_compare` | compare if two files are identical |
| `patch_create` | create a patch from two files |
| `patch_apply` | apply a patch to a file |
| `patch_revert` | revert the patch applied to a file |
| `cpu_type` | retrieve the CPU type from /proc/cpuinfo |
| `cpu_count` | retrieve the CPU count from /proc/cpuinfo |
| `cpu_flag` | check if a flag is present on the CPU |
| `os_name` | return the OS name |
| `os_version` | return the OS version |

### Strings package (`strings::`)

| function | description |
| --- | --- |
| `ltrim` | remove white spaces at the beginning of a string |
| `rtrim` | remove white spaces at the end of a string |
| `trim` | remove white spaces both a the beginning and end of a string |
| `to_upper` | convert a string to uppercase |
| `to_lower` | convert a string to lowercase |
| `length` | return the length of a string |
| `left` | extract N characters from the left |
| `right` | extract N characters from the right |
| `mid` | extract N characters from POS |

### Execute package (`execute::`)

| function | description |
| --- | --- |
| `wait_until` | wait n seconds before executing command |
| `run_in` | execute the command in the specified directory |
| `true` | always return TRUE (0) |
| `false` | always return FALSE (1) |

### GIT package (`git::`)

| function | description |
| --- | --- |
| `repo_name` | retrieve the GIT repository name |
| `repo_url` | retrieve the GIT origin URL |
| `local_dir` | retrieve the GIT local directory |
| `last_commit_sha1` | get the last commit SHA1 |
| `last_commit_sha1_short` | get the last commit SHA1 (short) |
| `active_branch` | retrieve the current active branch |
| `is_working_tree` | True if we are in a GIT working tree |

### Docker package (`docker::`)

| function | description |
| --- | --- |
| `log_path` | retrieve the log's path of a container |
| `get_name` | retrieve the name of a container |
| `get_id` | retrieve the ID of a container |
| `base_image` | retrieve the SHA256 of the base image |
| `base_image_short` | retrieve the short SHA256 of the base image |
| `image_tag` | retrieve the full tag of an image |
| `image_name` | retrieve the name of an image |
| `image_version` | retrieve the version of an image |
| `image_size` | return the size of the image in bytes |

