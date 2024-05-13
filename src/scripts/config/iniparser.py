#!/usr/bin/env python3
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Read a INI configuration file and extract the value specified by the user

#----- imports
import argparse
import logging
import sys

from configparser import ConfigParser, ExtendedInterpolation


#----- begin
# logger configuration
logger = logging.getLogger(__name__)
logging.basicConfig(format="%(asctime)s %(levelname)s %(message)s", level=logging.INFO)

# command line parser
parser = argparse.ArgumentParser()
parser.add_argument("-f", "--file", metavar="FILE", help="The INI configuration file")
parser.add_argument("-b", "--bool", action="store_true", default=False, help="Value is a boolean")
parser.add_argument("key", help="The key to look for in the file")
args = parser.parse_args()

# read the file
config = ConfigParser(interpolation=ExtendedInterpolation())
try:
    with open(args.file) as fh:
        config.read_file(fh)
except FileNotFoundError:
    logger.error(f"Cannot open INI file [{args.file}]")
    sys.exit(1)

# split the key in parts
section, option = args.key.split('.')

if not config.has_section(section):
    logger.error(f"Section [{section}] does not exist")
    sys.exit(1)

if not config.has_option(section, option):
    logger.error(f"Section [{section}] does not have a key [{option}]")
    sys.exit(1)

if args.bool:
    print(config.getboolean(section, option))
else:
    print(config.get(section, option))
