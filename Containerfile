FROM archlinux:latest

# Copy Hugo Binary into place (Specific to Github runners)
COPY hugo/hugo hugo

# Copy in the entrypoint
COPY entrypoint.sh entrypoint.sh

# Mark our enrtypoint
ENTRYPOINT entrypoint.sh