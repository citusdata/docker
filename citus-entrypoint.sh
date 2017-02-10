#!/bin/bash

# make bash behave
set -euo pipefail
IFS=$'\n\t'

# constants
workerlist=pg_worker_list.conf
citusconfdir=/etc/citus
externalworkerlist="$citusconfdir/$workerlist"

# create worker list file if it doesn't exist
touch "$externalworkerlist"

# ensure permissions, then symlink to datadir
chown postgres:postgres "$externalworkerlist"

# call PostgreSQL's ENTRYPOINT script
exec '/docker-entrypoint.sh' "$@"
