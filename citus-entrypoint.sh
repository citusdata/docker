#!/bin/bash

# make bash behave
set -euo pipefail
IFS=$'\n\t'

# constants
citusconfdir=/etc/citus

# call PostgreSQL's ENTRYPOINT script
exec '/docker-entrypoint.sh' "$@"
