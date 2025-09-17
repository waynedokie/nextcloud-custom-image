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

# --- THIS IS THE CORRECTED SECTION for installing go-vod ---
# Define the version and architecture to make it easy to update
ARG GOVOD_VERSION=0.8.2
ARG TARGETARCH=amd64

# Download the release, its checksum, verify it, and then install
RUN curl -L -o /tmp/go-vod.tar.gz "https://github.com/alexballas/go-vod/releases/download/v${GOVOD_VERSION}/go-vod_${GOVOD_VERSION}_linux_${TARGETARCH}.tar.gz" && \
    curl -L -o /tmp/checksums.txt "https://github.com/alexballas/go-vod/releases/download/v${GOVOD_VERSION}/checksums.txt" && \
    cd /tmp && \
    sha256sum -c checksums.txt --ignore-missing && \
    tar -zxvf go-vod.tar.gz -C /usr/local/bin/ go-vod && \
    rm /tmp/go-vod.tar.gz /tmp/checksums.txt
# -----------------------------------------------------------
