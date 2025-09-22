# Start from the official Nextcloud image
FROM nextcloud:latest

# Switch to the root user to install packages
USER root

# Install ffmpeg, exiftool, sudo, cron, and other dependencies needed for go-vod
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    libimage-exiftool-perl \
    sudo \
    cron \
    supervisor \
    curl && \
    rm -rf /var/lib/apt/lists/*

# Copy the supervisor configuration into the image
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Set the main command to start both cron and apache
CMD ["/usr/bin/supervisord"]
#CMD cron && apache2-foreground
