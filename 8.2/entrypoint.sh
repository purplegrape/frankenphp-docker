#!/usr/bin/env bash

RUNUSER=${RUNUSER:-999}
RUNGROUP=${RUNGROUP:-999}

if [ "$RUNUSER" != "999" ] && [ "$RUNGROUP" != "999" ]; then
    # If we're not running as expected user, fix permissions
    chown -R $RUNUSER:$RUNGROUP /var/lib/frankenphp
    exec gosu $RUNUSER:$RUNGROUP "$0"
fi


