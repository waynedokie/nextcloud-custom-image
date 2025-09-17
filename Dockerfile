# Start from the official Nextcloud image
FROM nextcloud:latest

# Switch to the root user to install packages
USER root

# Install ffmpeg, exiftool, sudo, and other dependencies needed for go-vod
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    libimage-exiftool-perl \
    sudo \
    curl

# --- ADD THIS SECTION to install go-vod ---
# Download and install the go-vod binary for amd64 architecture
RUN curl -L -o /tmp/go-vod.tar.gz https://github.com/alexballas/go-vod/releases/download/v0.8.2/go-vod_0.8.2_linux_amd64.tar.gz && \
    tar -zxvf /tmp/go-vod.tar.gz -C /usr/local/bin/ go-vod && \
    rm /tmp/go-vod.tar.gz
# ----------------------------------------

# The image's entrypoint script correctly handles switching to the www-data user.
