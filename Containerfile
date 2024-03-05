FROM archlinux:latest

RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm go git

# Copy Hugo Binary into place (Specific to Github runners)
COPY hugodir hugo

# Copy in the entrypoint
COPY entrypoint.sh entrypoint.sh

# Mark our enrtypoint
ENTRYPOINT ["/entrypoint.sh"]