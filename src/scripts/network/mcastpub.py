#!/usr/bin/env python3
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Multicast publisher with replay capabilities

#----- imports
import argparse
import time
import sys
import logging
import socket
import struct
import binascii


#----- globals
VERSION = "1.0.0"
DEFAULT_TTL = 1         # default TTL for multicast packet
DEFAULT_SLEEP = 2.0     # time between two multicast packet (in seconds)
DEFAULT_TIMEOUT = 0.2   # default socket timeout (in seconds)


#----- begin
# logger configuration
logger = logging.getLogger(__name__)
logging.basicConfig(format="%(asctime)s %(levelname)s %(message)s", level=logging.INFO)

# command line parser
parser = argparse.ArgumentParser(
    description="Multicast publisher with replay capabilities",
    usage="%(prog)s [options] mcast_addr:port"
)
parser.add_argument("-i", "--input", help="data file to use for replaying packets", metavar="FILE")
parser.add_argument("-t", "--ttl", default=DEFAULT_TTL, type=int, metavar="TTL", help="default TTL for multicast packet (default: %(default)s)")
parser.add_argument("-s", "--sleep", default=DEFAULT_SLEEP, type=float, metavar="SLEEP", help="default sleep time between packet (default: %(default)s s)")
parser.add_argument("-q", "--quiet", action="store_true", default=False, help="don't print feedback (default: %(default)s)")
parser.add_argument("--version", action="version", version='%(prog)s ' + f"v{VERSION}")
parser.add_argument("params", metavar="mcast_addr:port", help="Multicast address and port for publishing")
args = parser.parse_args()

# replay the file
handle = None
if args.input:
    try:
        handle = open(args.input, "rt")
    except FileNotFoundError:
        logger.error(f"Unable to open the file [{args.input}] for replay")
        sys.exit(1)

# retrieve the group & port from the parameters
try:
    mc_group, port = args.params.split(':')
except ValueError:
    logger.error(f"Unable to determine the address & port from [{args.params}]")
    sys.exit(1)

if len(port) == 0:
    logger.error(f"Please specify a port")
    sys.exit(1)

try:
    mc_port = int(port)
except ValueError:
    logger.error(f"Wrong port number specified [{port}]")
    sys.exit(1)

# create the UDP socket and set options
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.settimeout(DEFAULT_TIMEOUT)
sock.setsockopt(socket.IPPROTO_IP, socket.IP_MULTICAST_TTL, struct.pack('b', args.ttl))

# main loop
count = 1
while True:
    try:
        if handle:
            string = handle.readline().rstrip('\n\r')
            if len(string) == 0:
                break               # EOF reached

            string = binascii.unhexlify(string)
        else:
            string = f"This is message #{count}\n".encode("utf-8")

        if not args.quiet:
            logger.info(f"Sending packet #{count} ...")

        sock.sendto(string, (mc_group, mc_port))
        count = count + 1

        if args.sleep > 0:
            time.sleep(args.sleep)

    except KeyboardInterrupt:
        break

# close the socket
sock.close()
