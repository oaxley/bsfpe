#!/usr/bin/env python3
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Read a YAML configuration file and extract the value specified by the user

#----- imports
from __future__ import annotations
from typing import List, Dict

import yaml
import logging
import argparse
import sys


#----- begin

# logger configuration
logger = logging.getLogger(__name__)
logging.basicConfig(format="%(asctime)s %(levelname)s %(message)s", level=logging.INFO)

# command line parser
parser = argparse.ArgumentParser()
parser.add_argument("-f", "--file", metavar="FILE", help="The YAML configuration file")
parser.add_argument("key", help="The key to look for in the file")
args = parser.parse_args()

# read the file
try:
    with open(args.file) as fh:
        config = yaml.safe_load(fh)
except FileNotFoundError:
    logging.error(f"Cannot open YAML file [{args.file}]")
    sys.exit(1)

# split the key in parts
parts: List[str] = args.key.split('.')
option = parts[-1]

if len(parts) == 1:
    print(config[args.key])
    sys.exit(0)

# go through all the parts, minus the last one
path = ""
section = config
for part in parts[:-1]:
    if part.isdigit() and isinstance(section, list):
        try:
            section = section[int(part)]
        except IndexError:
            logger.error(f"Invalid index number '{part}' in {path}")
            sys.exit(1)
    elif isinstance(section, dict):
        try:
            section = section[part]
        except KeyError:
            logger.error(f"Invalid section name '{part}' in {path}")
            sys.exit(1)
    else:
        logger.error(f"Invalid part name '{part}' in {path}")
        sys.exit(1)

    if path == "":
        path = part
    else:
        path = path + f".{part}"

if isinstance(section, list):
    if option.isdigit():
        print(section[int(option)])

elif isinstance(section, dict):
    if option not in section:
        logger.error(f"Invalid option '{option}' in {path}")
        sys.exit(1)
    print(section[option])

else:
    logger.error(f"Invalid section type '{type(section)}'")
    sys.exit(1)
