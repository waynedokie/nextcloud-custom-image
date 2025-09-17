# Start from the official Nextcloud image
FROM nextcloud:latest

# Switch to the root user to install packages
USER root

# Install ffmpeg and its dependencies from the Debian repositories
RUN apt-get update && apt-get install -y --no-install-recommends ffmpeg

# Switch back to the default www-data user
#USER www-data
