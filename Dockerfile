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

