
# Quake II Server Docker Image

This Docker image runs a Quake II server using **Yamagi Quake II** (v.8.20). It allows users to upload game files, configure mods, and change server settings easily. By default, the server starts with the **baseq2** mod, but users can specify other mods through environment variables.

## Features
- Flexible mod support, allowing users to switch between mods like **lithium** or **openffa** (mod files must be provided by the user).
- Customizable configuration through environment variables.
- Exposes the default Quake II server port (27910/udp) for game connections (internal quake 2 server port can also be changed).
- Users can upload original Quake II game files and mod content using volumes.

## Requirements
You need to have the original Quake II files, especially `pak0.pak`, as they are required to run the server. These can be uploaded to the `baseq2` directory via a Docker volume.

## Getting Started

### 1. Pull the Image
```bash
docker pull docker.io/theshihan/quake2server:latest
```

### 2. Run the Container

You can start the Quake II server container by specifying the environment variables for the mod and config you wish to use.

```bash
docker run -d \
  -e Q2MODNAME=lithium \
  -e Q2MODCONFIG=server.cfg \
  -e Q2SERVERPORT=27910 \
  -v /path/to/baseq2:/usr/share/games/quake2/baseq2 \
  -v /path/to/lithium:/usr/share/games/quake2/lithium \
  -p 27910:27910/udp \
  docker.io/theshihan/quake2server:latest
```

- `Q2MODNAME`: The mod directory to be used (e.g., `opentdm`, `lithium`, `openffa`).
- `Q2MODCONFIG`: The configuration file to be executed for the server settings (default is `server.cfg`).
- `Q2SERVERPORT`: The (internal) port on which the Quake II server will listen (default is `27910`).
- `-v /path/to/baseq2`: A mapped volume for the `baseq2` directory, where you upload the `pak0.pak` file and other base Quake II files.
- `-v /path/to/mod`: A mapped volume for the mod directory, required.
- `-p 27910:27910/udp`: Maps the server port for external access.

### 3. Uploading Files
- **Base Game Files**: You **must** upload the `pak0.pak` file to `/usr/share/games/quake2/baseq2` using the mapped volume. Without this file, the server will not start.
- **Mod Files**: Upload the mod files to the respective directory. For example, the **lithium** mod should be placed inside `/usr/share/games/quake2/lithium`.

### 4. Access the Server
Once the server is running, connect to it using the server's IP and the port number you specified (default is `27910`, don't forget to open the port on your firewall):
```
quake2 +connect <server-address>:<server-port>
```

## Environment Variables

- **Q2MODNAME**: The mod directory to be used (default: `baseq2`).
- **Q2MODCONFIG**: The server configuration file (default: `server.cfg`).
- **Q2SERVERPORT**: The port for the Quake II server (default: `27910`).

## Volumes

- `/usr/share/games/quake2/baseq2`: **Required**. This volume is where the base game files, including `pak0.pak`, are stored.
- `/usr/share/games/quake2/<modname>`: **Required**. This volume is for custom mod files (e.g., `lithium`, `openffa`, etc.).

## Exposed Ports

- **27910/udp**: The default Quake II server port, configurable via the `Q2SERVERPORT` environment variable.

## Notes

- This Docker image does not include any Quake II content and is meant to run a server using user-provided game files.
- Ensure the mod directory name matches the standard directory name used by Quake II server browsers, such as `lithium` or `openffa`, for correct functionality.
