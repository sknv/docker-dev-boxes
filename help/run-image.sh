#!/usr/bin/env bash
# Run the image.

docker run --name=<container-name> -dt \
  -v <full-path-to-box>:/home/docker \
  -p <host-port>:<container-port> \
  <image-name>
