#!/bin/bash

# Check if running as root
if [ "$(id -u)" != 0 ]; then
    echo "Run as root"
    exit 1
fi

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -name) NAME="$2"; shift 2 ;;
        -ip) IP="$2"; shift 2 ;;
        -hostentry) HOST_NAME="$2"; HOST_IP="$3"; shift 3 ;;
        *) echo "Usage: $0 [-name <name>] [-ip <ip>] [-hostentry <name> <ip>]"; exit 1 ;;
    esac
done

# Change hostname
if [ -n "$NAME" ]; then
    echo "$NAME" > /etc/hostname
    hostname "$NAME"
fi


# Update hosts entry
if [ -n "$HOST_NAME" ] && [ -n "$HOST_IP" ]; then
    sed -i "/$HOST_NAME/d" /etc/hosts
    echo "$HOST_IP $HOST_NAME" >> /etc/hosts
fi
