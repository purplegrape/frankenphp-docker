#!/usr/bin/env bash

set -e

echo "Please specify your own SERVER_ROOT other than /usr/share/frankenphp"

if [ ! -d /data/www ]; then
    mkdir -p /data/www
    chown -R frankenphp:frankenphp /data/www
fi

if [ ! -L /var/www/html ];then
    mkdir -p /var/www
    ln -sf /data/www /var/www/html
fi

if [ $1 = "frankenphp" ]; then
    exec gosu frankenphp:frankenphp "$@"
else
    exec "$@"
fi
