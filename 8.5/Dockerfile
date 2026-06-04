# syntax=docker/dockerfile:1
FROM docker.io/redhat/ubi9-minimal:latest
LABEL org.opencontainers.image.title=FrankenPHP \
      org.opencontainers.image.version=1.12 \
      org.opencontainers.image.url=https://frankenphp.dev \
      org.opencontainers.image.source=https://github.com/php/frankenphp \
      org.opencontainers.image.licenses=MIT \
      org.opencontainers.image.phpversion=8.5

RUN rpm -Uvh https://rpm.henderkes.com/static-php-1-1.noarch.rpm && \
    microdnf update -y && \
    microdnf module enable -y php-zts:static-8.5 && \
    microdnf install -y \
		frankenphp \
		php-zts-apcu \
		php-zts-bcmath \
		php-zts-cli \
		php-zts-gd \
		php-zts-ldap \
		php-zts-memcached \
		php-zts-msgpack \
		php-zts-mysqli \
		php-zts-mysqlnd \
		php-zts-opentelemetry \
		php-zts-redis \
		php-zts-soap \
		php-zts-zip \
		php-zts-zstd \
		tzdata && \
    microdnf clean all

# full list of avaiable php-zts packages
#	php-zts-amqp
#	php-zts-apcu
#	php-zts-ast
#	php-zts-bcmath
#	php-zts-brotli
#	php-zts-bz2
#	php-zts-cgi
#	php-zts-cli
#	php-zts-dba
#	php-zts-devel
#	php-zts-dio
#	php-zts-ds
#	php-zts-embed
#	php-zts-ev
#	php-zts-event
#	php-zts-ffi
#	php-zts-fileinfo
#	php-zts-fpm
#	php-zts-ftp
#	php-zts-gd
#	php-zts-gettext
#	php-zts-gmp
#	php-zts-gmssl
#	php-zts-grpc
#	php-zts-igbinary
#	php-zts-imagick
#	php-zts-inotify
#	php-zts-intl
#	php-zts-ldap
#	php-zts-lz4
#	php-zts-maxminddb
#	php-zts-memcache
#	php-zts-memcached
#	php-zts-mongodb
#	php-zts-msgpack
#	php-zts-mysqli
#	php-zts-mysqlnd
#	php-zts-odbc
#	php-zts-opentelemetry
#	php-zts-parallel
#	php-zts-pcov
#	php-zts-pdo
#	php-zts-pdo_mysql
#	php-zts-pdo_odbc
#	php-zts-pdo_pgsql
#	php-zts-pdo_sqlite
#	php-zts-pdo_sqlsrv
#	php-zts-pgsql
#	php-zts-protobuf
#	php-zts-rar
#	php-zts-rdkafka
#	php-zts-redis
#	php-zts-shmop
#	php-zts-simdjson
#	php-zts-snappy
#	php-zts-soap
#	php-zts-spx
#	php-zts-sqlite3
#	php-zts-sqlsrv
#	php-zts-ssh2
#	php-zts-swoole
#	php-zts-sysvmsg
#	php-zts-sysvsem
#	php-zts-sysvshm
#	php-zts-tidy
#	php-zts-trader
#	php-zts-uuid
#	php-zts-uv
#	php-zts-xdebug
#	php-zts-xhprof
#	php-zts-xlswriter
#	php-zts-xsl
#	php-zts-xz
#	php-zts-yac
#	php-zts-yaml
#	php-zts-zip
#	php-zts-zstd

RUN chown -R frankenphp:frankenphp /var/lib/frankenphp /var/lib/php-zts
RUN echo "<?php phpinfo(); ?>" > /usr/share/frankenphp/info.php

COPY --from=tianon/gosu --chmod=755 /gosu /usr/bin/
COPY --chmod=755 entrypoint.sh /entrypoint.sh
COPY Caddyfile /etc/frankenphp/Caddyfile
COPY php.ini-production /etc/frankenphp/php.ini

# Restart the Worker After a Certain Number of Requests
# ENV MAX_REQUESTS=1000

# Enable debug mode
# ENV CADDY_GLOBAL_OPTIONS=debug

# set your own serverroot:
# ENV SERVER_ROOT=/data/www

VOLUME [ "/app" ]
WORKDIR /etc/frankenphp
ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "frankenphp","run" ]
EXPOSE 8080/tcp 8443/tcp
