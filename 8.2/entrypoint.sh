#!/usr/bin/env bash

set -e

if [ ! -d /data/www ]; then
    mkdir -p /data/www
    chown -R frankenphp:frankenphp /data/www
fi

if [ ! -L /var/www/html ];then
    ln -sf /data/www /var/www/html
fi

if [ $1 = "frankenphp" ]; then
    exec gosu frankenphp:frankenphp "$@"
else
    exec "$@"
fi
