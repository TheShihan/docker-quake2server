# Use the latest stable Debian release (Bookworm) as the base image
FROM debian:bookworm-slim

# Add contrib and non-free repositories
RUN echo "deb http://deb.debian.org/debian bookworm main contrib non-free" > /etc/apt/sources.list && \
    echo "deb-src http://deb.debian.org/debian bookworm main contrib non-free" >> /etc/apt/sources.list && \
    apt-get update

# Install necessary packages
RUN apt-get install -y quake2-server yamagi-quake2 curl wget libopenal1 libogg0 libvorbis0a libsdl2-2.0-0 ca-certificates && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Create the quake2-server user and group if necessary
RUN groupadd -r quake2-server || true && useradd -r -g quake2-server quake2-server || true

# Ensure the server has permission to write to /usr/share/games/quake2
RUN mkdir -p /usr/share/games/quake2/baseq2 && \
    chown -R quake2-server:quake2-server /usr/share/games/quake2

# Switch to quake2-server user
USER quake2-server

# Set the working directory
WORKDIR /usr/share/games/quake2

# Copy a default server configuration file into the container
COPY server.cfg /usr/share/games/quake2/baseq2/server.cfg

# Expose the default Quake II server port
EXPOSE 27910/udp

# Define the entry point and default command
ENTRYPOINT ["/usr/games/quake2-server"]
CMD ["+set", "dedicated", "1", "+map", "q2dm1", "+exec", "server.cfg"]
