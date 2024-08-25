
# Quake 2 Dedicated Server in Docker

This repository contains a simple Docker setup to run a **Quake 2 Dedicated Server** using the latest **Yamagi Quake II** engine and the original Quake 2 game assets. The server is configured to run a customizable `server.cfg` file, and you can easily mount your own `quake2` directory for custom mods and persistent data.

## Features

- **Yamagi Quake II**: Latest version of the Yamagi Quake II engine is automatically downloaded from GitHub.
- **Original Quake 2 Assets**: Includes the original game files (`pak0.pak`, `pak1.pak`, etc.) from the `quake2-data` package.
- **Custom Configurations**: Server executes `server.cfg` automatically, allowing you to customize the server behavior.
- **Volume Mapping**: Mount your own Quake 2 directory to add mods, maps, or custom configuration files.
- **Writable Directory**: The mapped volume is writable, ensuring highscores, logs, and mods can persist.

## How to Use

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/quake2-server-docker.git
cd quake2-server-docker
```

### 2. Build the Docker Image

To build the image, run the following command:

```bash
docker build -t quake2-server .
```

### 3. Run the Server

You can start the Quake 2 server with the following command, mapping a local directory for the Quake 2 data:

```bash
docker run -d -p 27910:27910/udp -v /path/to/your/quake2:/quake2 --name quake2 quake2-server
```

- `/path/to/your/quake2` is the directory on your host where you can store your mods, custom maps, and configuration files (like `server.cfg`).

### 4. Server Configuration (`server.cfg`)

You can place a `server.cfg` file in your local Quake 2 directory (`/path/to/your/quake2/baseq2/server.cfg`), and the server will automatically execute it on startup. This file can contain important settings like the server name, RCON password, map rotations, etc.

Example `server.cfg`:

```cfg
// Basic server settings
hostname "My Quake 2 Server"
rcon_password "myrconpassword"
maxclients 16
timelimit 20
fraglimit 50

// Map rotation
map q2dm1
map q2dm2
map q2dm3
```

### 5. Restarting the Server

After making changes to the `server.cfg` or adding new mods/maps, you can restart the container to apply the changes:

```bash
docker restart quake2
```

### 6. Logs and Status

To check the logs and verify the server is running, use:

```bash
docker logs quake2
```

---

## Mapping the Quake 2 Directory

To ensure the server uses your own configuration and allows modding, you should map your own `quake2` directory on your host to the container’s `/quake2` directory.

This allows you to:

- **Add Custom Mods**: Drop custom mods into `/path/to/your/quake2/baseq2/`.
- **Modify Server Config**: Place or modify the `server.cfg` in `/path/to/your/quake2/baseq2/`.
- **Persistence**: Server logs, highscores, and other persistent data are saved.

### Example Directory Structure

```bash
/path/to/your/quake2/
├── baseq2/
│   ├── pak0.pak  # Original Quake 2 data (provided by the image)
│   ├── server.cfg  # Your custom server configuration
│   ├── maps/  # Custom maps (if needed)
│   └── .../  # Other stuff (if needed)
```

---

## Important Notes

- **Ports**: The server listens on the default Quake 2 port `27910/udp`. Ensure this port is open on your firewall or router if hosting for external players.
- **Custom Mods/Maps**: You can download custom maps or mods and place them in the `baseq2` directory of your mapped folder.
- **Original Maps**: The server includes the original Quake 2 maps (`q2dm1` to `q2dm8`) and assets.

---

## License

This repository is open-source under the MIT License. The original Quake 2 game files are the property of id Software.

---

## Troubleshooting

- **Server Not Starting**: Check the container logs for errors with `docker logs quake2`.
- **Custom Maps Not Loading**: Ensure they are placed in the correct directory (`baseq2/maps`) inside your mapped volume.
