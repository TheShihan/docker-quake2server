# Use the latest stable Debian release (Bookworm) as the base image
FROM debian:bookworm-slim

# Set default environment variables in uppercase
ENV Q2MODNAME=baseq2
ENV Q2MODCONFIG=server.cfg
ENV Q2SERVERPORT=27910

# Add contrib and non-free repositories
RUN echo "deb http://deb.debian.org/debian bookworm main contrib non-free" > /etc/apt/sources.list && \
    apt-get update

# Install necessary packages for building Q2Pro dedicated server
RUN apt-get install -y meson gcc libc6-dev zlib1g-dev git && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Clone and build Q2Pro from GitHub
RUN git clone https://github.com/skullernet/q2pro.git /tmp/q2pro && \
    cd /tmp/q2pro && \
    meson setup builddir && \
    meson configure builddir -Dprefix=/usr && \
    meson compile -C builddir && \
    ninja -C builddir install && \
    rm -rf /tmp/q2pro

# Create the quake2-server user and group if necessary
RUN groupadd -r -g 1001 quake2-server && useradd -r -g quake2-server -m -d /home/quake2-server -s /bin/bash -u 1001 quake2-server

# Create necessary directories and set permissions
RUN chown -R quake2-server:quake2-server /usr/share/q2pro && \
    chmod -R 755 /usr/share/q2pro

# Copy the server start script into the container
COPY start-quake2-server.sh /home/quake2-server/start-quake2-server.sh
RUN chmod +x /home/quake2-server/start-quake2-server.sh && \
    chown -R quake2-server:quake2-server /home/quake2-server

# Switch to the quake2-server user
USER quake2-server

# Create necessary directories inside home dir of user
RUN mkdir -p /home/quake2-server/.q2pro/baseq2

# Declare q2pro homedir as a volume so users can upload mods (or baseq2)
VOLUME /home/quake2-server/.q2pro

# Alternate baseq2 location
VOLUME /usr/share/q2pro/baseq2

# Expose the default Quake II server port (can be changed using the Q2SERVERPORT environment variable)
EXPOSE 27910/udp

# Define the entry point to the start script
ENTRYPOINT ["/home/quake2-server/start-quake2-server.sh"]
