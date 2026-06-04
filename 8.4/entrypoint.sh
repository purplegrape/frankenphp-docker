#!/usr/bin/env bash

set -e

if [ -f Caddyfile ]; then
    frankenphp fmt --overwrite Caddyfile
fi

if [ -z "$FRANKENPHP_CONFIG" ]; then
    export FRANKENPHP_CONFIG="num_threads 2;max_threads 4"
fi

if [ ! -d /app/public ]; then
    mkdir -p /app/public
    chown -R frankenphp:frankenphp /app/public
fi

if [ $1 = "frankenphp" ]; then
    exec gosu frankenphp:frankenphp "$@"
else
    exec "$@"
fi
