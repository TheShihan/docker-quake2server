# Quake II Server Docker Image

This repository provides a Docker image for running a Quake II server using [Yamagi Quake II](https://yamagi.org/quake2/) on Debian Bookworm. This setup enables you to quickly deploy and manage a Quake II server with minimal configuration.

## Overview

- **Base Image**: `debian:bookworm-slim`
- **Quake II Version**: Yamagi Quake II (v8.20)
- **Included Packages**: `quake2-server`, `yamagi-quake2`

## Features

- **Pre-configured Quake II Server**: Includes the necessary components to run a Quake II server.
- **Customizable Configuration**: Allows you to provide your own `server.cfg` file for server configuration.
- **Simple Setup**: Built on Debian Bookworm, using official repositories for installation.

## Configuration

### Basic setup

The server needs (at least) the original pak0.pak from the Quake II installation medium which cannot be provided here for legal reasons.
Map the baseq2 folder of the container and place the pak0.pak file inside that folder. You can place additional paks there if you need them for the server, for example the original pak1.pak that contains the q2dm1 to q2dm8 deathmatch maps.

For example:
```
docker run -d --name quake2-server \
  -v /path/to/your/baseq2:/usr/share/games/quake2/baseq2 \
  ...
```

(If you want to host games of 'xatrix' or 'rogue' modifications, you also have to map volumes to those mod folders and place the required pak files there).

Change the 'startmap' ENV var if you want another map than 'q2dm1' to be used as inital map for the server startup.

Change the 'serverconfig' ENV var if you want to set the name of the server config (*.cfg) to be loaded at startup. Your server configuration for your mod needs to be placed inside this file and this file must be stored in the baseq2 directory (not in the mod directory).

**Important:** This file is required and the server cannot start without a server configuration!

Don't forget to switch to the correct mod inside the server config (`set game modname`).

### Setup the mod

To run your desired mod (modification) on the server you have to set the environment variable 'modname' to the desired value (e.g. 'lithium' or 'openffa' etc.). The default value is 'baseq2'.
Map the mod directory of the container to a directory on your host containing the required files for the mod (for example the 'game.so').

```
docker run -d --name quake2-server \
  ...
  -v /path/to/your/moddir:/usr/share/games/quake2/moddir \
  ...
```

(where moddir has the value of the 'modname' environment variable of the docker container.)

### Server Port

The server always runs on the default port 27910 inside the container but you can map the (external) port of your liking to this internal port.
