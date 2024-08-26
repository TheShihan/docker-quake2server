# Use the latest stable Debian release (Bookworm) as the base image
FROM debian:bookworm-slim

# Set default environment variables in uppercase
ENV Q2MODNAME=baseq2
ENV Q2MODCONFIG=server.cfg
ENV Q2SERVERPORT=27910

# Add contrib and non-free repositories
RUN echo "deb http://deb.debian.org/debian bookworm main contrib non-free" > /etc/apt/sources.list && \
    apt-get update

# Install necessary packages
RUN apt-get install -y yamagi-quake2 quake2-server && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Create the quake2-server user and group if necessary
RUN groupadd -r quake2-server || true && useradd -r -g quake2-server quake2-server || true

# Create necessary directories and set permissions
RUN mkdir -p /usr/share/games/quake2/init && \
    chown -R quake2-server:quake2-server /usr/share/games/quake2

# Copy the server start script into the container
COPY start-quake2-server.sh /usr/local/bin/start-quake2-server.sh
RUN chmod +x /usr/local/bin/start-quake2-server.sh

# Declare baseq2 as a volume so users can upload pak0.pak and other files
VOLUME /usr/share/games/quake2/baseq2

# Switch to the quake2-server user
USER quake2-server

# Expose the default Quake II server port (can be changed using the Q2SERVERPORT environment variable)
EXPOSE 27910/udp

# Define the entry point to the start script
ENTRYPOINT ["/usr/local/bin/start-quake2-server.sh"]
