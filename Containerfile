FROM archlinux:latest

# Update packages
RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm go

# Copy Hugo Binary into place (Specific to Github runners)
COPY hugo hugo

# Copy in the entrypoint
COPY entrypoint.sh entrypoint.sh

# Mark our enrtypoint
ENTRYPOINT ["/entrypoint.sh"]