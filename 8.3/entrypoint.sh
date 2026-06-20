#!/usr/bin/env bash

set -e

if [ -f Caddyfile ]; then
    frankenphp fmt --overwrite Caddyfile
fi

if [ ! -d /app/public ]; then
    mkdir -p /app/public
    chown -R frankenphp:frankenphp /app/public
fi

if [ $1 = "frankenphp" ]; then
    setcap -r /usr/bin/frankenphp
    exec gosu frankenphp:frankenphp "$@"
else
    exec "$@"
fi
