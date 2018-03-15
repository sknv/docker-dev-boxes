#!/usr/bin/env bash
# Entry point for a Docker image.

# TODO: Uncomment required entry point or use a default one.

/bin/bash # Default cmd.
# mongod --dbpath "$MONGODATA" # Start Mongod.
service postgresql start && /bin/bash # Start PostgreSQL.
