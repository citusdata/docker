#!/bin/bash

# make bash behave
set -euo pipefail
IFS=$'\n\t'

# call PostgreSQL's ENTRYPOINT script
./docker-entrypoint.sh postgres

# create worker list file link and Citus extension
./000-symlink-workerlist.sh
psql 001-create-citus-extension.sql
