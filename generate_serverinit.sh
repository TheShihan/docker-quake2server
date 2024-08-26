#!/bin/sh
# Bash script to create directories and generate serverinit.cfg

modname=$1

# Create the mod directory and init directory
mkdir -p /usr/share/games/quake2/${modname} && \
mkdir -p /usr/share/games/quake2/init

# Generate serverinit.cfg with the appropriate modname
cat <<EOF > /usr/share/games/quake2/init/serverinit.cfg
// Docker image quake 2 server mod initialization
echo Starting mod: ${modname}
set game ${modname}
exec server.cfg
EOF
