#!/usr/bin/env bash
# Run the image.

# TODO: Uncomment required volume.

docker run -dt \
  --name=<container-name> \
  -v "$(pwd)":/home/docker \
  # Volume for MongoDB.
  # -v <image-name>-mongo-data:/data/mongodb \
  # Volume for PostgreSQL.
  # -v <image-name>-pg-data:/data/postgresql \
  -p <host-port>:<container-port> \
  <image-name>
