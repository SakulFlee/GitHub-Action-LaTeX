# Use ArchLinux as a base (always up-to-date)
FROM archlinux:latest

# Install `TexLive-Most` package.
# Note: Contains _most_ of the required LaTeX pacakges.
RUN pacman -Sy \
    && pacman -S --noconfirm texlive-most

# Copy entrypoint
COPY entrypoint.sh /

# Set entrypoint
ENTRYPOINT ["/entrypoint.sh"]
