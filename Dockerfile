# Use ArchLinux as a base (always up-to-date)
FROM archlinux:latest

# Install `TexLive-Most` package.
# Note: Contains _most_ of the required LaTeX pacakges.
RUN pacman -Syu --noconfirm base base-devel texlive 

# Entrypoint
## Copy entrypoint
COPY entrypoint.sh /

## Mark entrypoint as executable
RUN chmod +x /entrypoint.sh

## Set entrypoint
ENTRYPOINT ["/entrypoint.sh"]
