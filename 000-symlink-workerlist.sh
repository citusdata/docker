#!/bin/bash

# make bash behave
set -euo pipefail
IFS=$'\n\t'

# constants
workerlist=pg_worker_list.conf
citusconfdir=/etc/citus
externalworkerlist="$citusconfdir/$workerlist"

ln -s "$externalworkerlist" "$PGDATA/$workerlist"
