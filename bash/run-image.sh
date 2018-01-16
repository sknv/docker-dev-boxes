#!/usr/bin/env bash
# Run the image.

docker run -dt \
  --name=<container-name> \
  -v "$(pwd)":/home/docker \
  -p <host-port>:<container-port> \
  <image-name>
