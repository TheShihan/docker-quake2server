#!/bin/sh

# Use environment variables for mod name and server config file
Q2MODNAME=${Q2MODNAME:-baseq2}          # Default to baseq2 if not provided
Q2MODCONFIG=${Q2MODCONFIG:-server.cfg}  # Default to server.cfg if not provided
Q2SERVERPORT=${Q2SERVERPORT:-27910}     # Default port if not provided

# Check if the mod directory exists, create it if necessary
MODDIR="/home/quake2-server/.q2pro/${Q2MODNAME}"

if [ ! -d "$MODDIR" ]; then
    echo "Creating mod directory: $MODDIR"
    mkdir -p "$MODDIR"
    chown quake2-server:quake2-server "$MODDIR"
fi

# Start the q2Pro server with the specified mod
echo "Starting q2Pro server (port: $Q2SERVERPORT) with mod: $Q2MODNAME"
exec /usr/bin/q2proded +set net_port "$Q2SERVERPORT" +game "$Q2MODNAME" +exec "$Q2MODCONFIG"
