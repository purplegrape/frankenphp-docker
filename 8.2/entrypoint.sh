#!/usr/bin/env bash

set -e

XDG_CONFIG_HOME=/app/.config
XDG_DATA_HOME=/app/.local/share

if [ ! -d /app/.config ]; then
    mkdir -p /app/.config
    chown -R frankenphp:frankenphp /app/.config
fi

if [ ! -d /app/.local/share ]; then
    mkdir -p /app/.local/share
    chown -R frankenphp:frankenphp /app/.local
fi

if [ -f Caddyfile ]; then
    frankenphp fmt --overwrite Caddyfile
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
