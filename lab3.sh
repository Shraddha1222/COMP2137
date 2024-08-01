#!/bin/bash

# Check if verbose mode is enabled
if [ "$1" = "-verbose" ]; then
    VERBOSE=1
    shift
fi

# Transfer configure-host.sh script to each server
scp configure-host.sh remoteadmin@server1-mgmt:/root
scp configure-host.sh remoteadmin@server2-mgmt:/root

# Run configure-host.sh script on each server
ssh remoteadmin@server1-mgmt -- /root/configure-host.sh -name loghost -ip 192.168.16.3 -hostentry webhost 192.168.16.4 $([ "$VERBOSE" = 1 ] && echo "-verbose")
ssh remoteadmin@server2-mgmt -- /root/configure-host.sh -name webhost -ip 192.168.16.4 -hostentry loghost 192.168.16.3 $([ "$VERBOSE" = 1 ] && echo "-verbose")

# Update local /etc/hosts file
./configure-host.sh -hostentry loghost 192.168.16.3 $([ "$VERBOSE" = 1 ] && echo "-verbose")
./configure-host.sh -hostentry webhost 192.168.16.4 $([ "$VERBOSE" = 1 ] && echo "-verbose")
