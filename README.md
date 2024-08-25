# Quake II Server Docker Image

This repository provides a Docker image for running a Quake II server using [Yamagi Quake II](https://yamagi.org/quake2/) on Debian Bookworm. This setup enables you to quickly deploy and manage a Quake II server with minimal configuration.

## Overview

- **Base Image**: `debian:bookworm-slim`
- **Quake II Version**: Yamagi Quake II
- **Included Packages**: `quake2-server`, `yamagi-quake2`

## Features

- **Pre-configured Quake II Server**: Includes the necessary components to run a Quake II server.
- **Customizable Configuration**: Allows you to provide your own `server.cfg` file for server configuration.
- **Simple Setup**: Built on Debian Bookworm, using official repositories for installation.
