#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Bash Wrapper around configuration parsers

#----- guards
# ensure python is available
__bin=$(which python3)
[[ -z "${__bin}" ]] && return


#----- functions
#.--
#.1 Get the associated value of a key in the INI file
#.2 (-s|--sections){Print all available sections from the file.|\fBsection\fR must be set to 'all'.}
#.2 (-k|--keys){Print all the available keys in a section.|\fBsection\fR must be set to the corresponding section.}
#.2 (-f|--file=filename){The INI configuration file}
#.2 (key|section){The key or section to look for (see examples)}
#.3H Read the INI configuration file and look for the \fBsection.key\fR in the file.
#.3H If the key is found, prints its value.
#.3F The command returns 0 if successful, 1 otherwise.
#.4 Retrieve the database username in the credentials.ini file
#.4 $ config::ini --file credentials.ini database.username
#.4 Print all the available sections
#.4 $ config::ini -s --file credentials.ini all
#.--
config::ini() {
  python3 "${BSFPE_LIBRARY_DIR}/lib/config/iniparser.py" "$@"
}

#.--
#.1 Get the associated value of a key in the YAML file
#.2 (-s|--sections){Print all available sections from the file.|\fBsection\fR must be set to 'all'.}
#.2 (-k|--keys){Print all the available keys in a section.|\fBsection\fR must be set to the corresponding section.}
#.2 (-f|--file=filename){The YAML configuration file}
#.2 (key|section){The key or section to look for (see examples)}
#.3H Read the YAML configuration file and look for the \fBsection.key\fR in the file.
#.3H If the key is found, prints its value.
#.3F The command returns 0 if successful, 1 otherwise.
#.4 Retrieve the database ports (a list) in the sample.toml file
#.4 $ config::toml -f sample.toml database.ports
#.4 Retrieve the first port (index 0) in the list
#.4 $ config::toml -f sample.toml database.ports.0
#.--
config::yaml() {
  python3 "${BSFPE_LIBRARY_DIR}/lib/config/yamlparser.py" "$@"
}

#.--
#.1 Get the associated value of a key in the TOML file
#.2 (-s|--sections){Print all available sections from the file.|\fBsection\fR must be set to 'all'.}
#.2 (-k|--keys){Print all the available keys in a section.|\fBsection\fR must be set to the corresponding section.}
#.2 (-f|--file=filename){The TOML configuration file}
#.2 (key|section){The key or section to look for (see examples)}
#.3H Read the TOML configuration file and look for the \fBsection.key\fR in the file.
#.3H If the key is found, prints its value.
#.3F The command returns 0 if successful, 1 otherwise.
#.4 Retrieve the docker image name in the sample.yaml file
#.4 $ config::yaml -f sample.yaml jobs.build.docker.0.image
#.--
config::toml() {
  python3 "${BSFPE_LIBRARY_DIR}/lib/config/tomlparser.py" "$@"
}
