# Use the latest stable Debian release (Bookworm) as the base image
FROM debian:bookworm-slim

# Set modname as an environment variable
ENV modname=baseq2

# Add contrib and non-free repositories
RUN echo "deb http://deb.debian.org/debian bookworm main contrib non-free" > /etc/apt/sources.list && \
    echo "deb-src http://deb.debian.org/debian bookworm main contrib non-free" >> /etc/apt/sources.list && \
    apt-get update

# Install necessary packages
RUN apt-get install -y yamagi-quake2 quake2-server && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Create the quake2-server user and group
RUN groupadd -r quake2-server || true && useradd -r -g quake2-server quake2-server || true

# Copy script to the container that generates the serverinit.cfg
COPY generate_serverinit.sh /usr/local/bin/generate_serverinit.sh
RUN chmod +x /usr/local/bin/generate_serverinit.sh

# Generate directories and serverinit.cfg based on modname
RUN /usr/local/bin/generate_serverinit.sh ${modname}

# Switch to quake2-server user
USER quake2-server

# Expose the default Quake II server port
EXPOSE 27910/udp

# Define the entry point
ENTRYPOINT ["/usr/games/quake2-server"]

# Startup commands
CMD ["+game", "init", "+exec", "serverinit.cfg"]
