#!/usr/bin/env python3
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Multicast receiver with record capabilities

#----- imports
import argparse
import sys
import logging
import socket
import struct
import binascii
import fcntl


#----- globals
VERSION = "1.0.0"
DEFAULT_BUFSIZE = 4096      # default buffer size


#----- functions
# retrieve the IP address of an interface from a socket descriptor
# Args:
#   the interface to query from
# Return:
#   the IP address of this interface
def getIPAddress(ifname: str) -> str:
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    return socket.inet_ntoa(
        fcntl.ioctl(s.fileno(),
                    0x8915,  # SIOCGIFADDR
                    struct.pack('256s', ifname[:15])
        )[20:24]
    )

#----- begin
# logger configuration
logger = logging.getLogger(__name__)
logging.basicConfig(format="%(asctime)s %(levelname)s %(message)s", level=logging.INFO)

# command line parser
parser = argparse.ArgumentParser(
    description="Multicast receiver with record capabilities",
    usage="%(prog)s [options] mcast_addr:port"
)
parser.add_argument("-o", "--output", help="data file to use for recording packets", metavar="FILE")
parser.add_argument("-i", "--iface", help="interface to use for receiving", metavar="IFACE")
parser.add_argument("-q", "--quiet", action="store_true", default=False, help="don't print feedback (default: %(default)s)")
parser.add_argument("--version", action="version", version='%(prog)s ' + f"v{VERSION}")
parser.add_argument("params", metavar="mcast_addr:port", help="Multicast address and port for receiving")
args = parser.parse_args()

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
sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
sock.bind(('', mc_port))

# multicast setup
if args.iface:
    ip = getIPAddress(args.iface)
    mreq = socket.inet_aton(mc_group) + socket.inet_aton(ip)
else:
    group = socket.inet_aton(mc_group)
    mreq = struct.pack('4sL', group, socket.INADDR_ANY)
sock.setsockopt(socket.IPPROTO_IP, socket.IP_ADD_MEMBERSHIP, mreq)


# main loop
if not args.quiet:
    logger.info(f"Waiting for data ...")

while True:
    try:
        # read the socket
        data, address = sock.recvfrom(DEFAULT_BUFSIZE)

        if not args.quiet:
            logging.info(f"Received [{len(data)}] bytes from {address}")

        # write the data to a file
        if args.output:
            try:
                with open(args.output, "at") as fh:
                    data = binascii.hexlify(data).decode()
                    fh.write(f"{data}\n")
            except Exception as e:
                logger.error(f"Unable to write data: {str(e)}")

    except KeyboardInterrupt:
        break

# close the socket
sock.close()
