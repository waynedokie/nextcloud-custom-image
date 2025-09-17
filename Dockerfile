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

ARG GOVOD_VERSION=0.8.2
ARG TARGETARCH=amd64

# Use 'set -e' to ensure the script exits immediately on error
# Separate commands make debugging easier
RUN set -e; \
    # Download the release and its checksum
    curl -L -o /tmp/go-vod.tar.gz "https://github.com/alexballas/go-vod/releases/download/v${GOVOD_VERSION}/go-vod_${GOVOD_VERSION}_linux_${TARGETARCH}.tar.gz"; \
    curl -L -o /tmp/checksums.txt "https://github.com/alexballas/go-vod/releases/download/v${GOVOD_VERSION}/checksums.txt"; \
    # Verify the download
    cd /tmp; \
    sha256sum -c checksums.txt --ignore-missing; \
    # Extract the binary
    tar -zxvf go-vod.tar.gz -C /usr/local/bin/ go-vod; \
    # Clean up
    rm /tmp/go-vod.tar.gz /tmp/checksums.txt
