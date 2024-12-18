#!/bin/bash
#
# @author   Sebastien LEGRAND
# @license  MIT License
#
# @brief    Network functions with python as a backend

#----- guards
# ensure python is available
__bin=$(which python3)
[[ -z ${__bin} ]] && return 0

#----- functions
#.--
#.1 Publish multicast traffic
#.2 (-i|--input=FILE){The file for multicast replay.}
#.2 (-t|--ttl=TTL){TTL for multicast packets (default:1).}
#.2 (-s|--sleep=time){Time between packet send (default:2s).}
#.2 (-q|--quiet){Supress output.}
#.2 (address:port){Multicast address & port.}
#.3H This script will publish multicast traffic to the specified address and port. !!
#.3H If a file, generated by \fBnetwork::mcast_recv\fR, is specified, the publisher will replay it.
#.3F The default TTL is set to 1 to avoid broadcasting multicast traffic outside of the local LAN.
#.4 Publish standard message to multicast
#.4 $ network::mcast_pub 224.0.0.1:35000
#.4 Replay the market data to local LAN
#.4 $ network::mcast_pub -i market_data.bin 224.0.0.1:35000
#.--
network::mcast_pub() {
  python3 "${BSFPE_LIBRARY_DIR}/lib/network/mcastpub.py" "$@"
}

#.--
#.1 Receive multicast traffic
#.2 (-o|--output=FILE){The file for multicast recording.}
#.2 (-i|--iface=IFACE){Interface to bind to for listening to multicast traffic.}
#.2 (-q|--quiet){Supress output.}
#.2 (address:port){Multicast address & port.}
#.3H This script will listen to multicast traffic to the specified address and port.
#.3H If necessary, a specific interface can be set. !!
#.3H A file can be generated, compatible with \fBnetwork::mcast_pub\fR, for replay purposes.
#.4 Receive standard message from multicast
#.4 $ network::mcast_recv 224.0.0.1:35000
#.4 Record the market data to a file
#.4 $ network::mcast_recv -o market_data.bin 224.0.0.1:35000
#.--
network::mcast_recv() {
  python3 "${BSFPE_LIBRARY_DIR}/lib/network/mcastrcv.py" "$@"
}

#.--
#.1 Create a HTTP listener
#.2 (port){The TCP \fBport\fR to listen to.}
#.3H This function will open a TCP port and listen for HTTP connection. !!
#.3H The only use case is in conjonction with \fBnetwork::zero_connect\fR to test a connection end to end.
#.4 Open a HTTP listener on port 8000
#.4 $ network::fake_server 8000
#.--
network::fake_server() {
  python3 -m http.server "$1"
}

