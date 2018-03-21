#!/usr/bin/env bash
# Entry point for a Docker image.

# TODO: Uncomment required entry point or use a default one.

/bin/bash # Default cmd.
# mongod --fork --dbpath "$MONGODATA" --logpath "$MONGOLOG" && /bin/bash # Start Mongod.
# su -l -c "/usr/lib/postgresql/$POSTGRESQL_VERSION/bin/pg_ctl -D $PGDATA -l $PGLOG start" postgres && /bin/bash # Start PostgreSQL.
