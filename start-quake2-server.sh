#!/bin/bash

# Use environment variables for mod name and server config file
Q2MODNAME=${Q2MODNAME:-baseq2}          # Default to baseq2 if not provided
Q2MODCONFIG=${Q2MODCONFIG:-server.cfg}  # Default to server.cfg if not provided
Q2SERVERPORT=${Q2SERVERPORT:-27910}     # Default port if not provided

# Ensure the home directory and quake server directory has the correct ownership
chown -R quake2-server:quake2-server /home/quake2-server
chown -R quake2-server:quake2-server /usr/share/q2pro

# Start the q2Pro server with the specified mod
echo "Starting q2Pro server (port: $Q2SERVERPORT) with mod: $Q2MODNAME"
exec /usr/bin/q2proded +set net_port "$Q2SERVERPORT" +set game "$Q2MODNAME" +exec "$Q2MODCONFIG"
