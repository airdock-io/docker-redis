# VERSION 1.0
# AUTHOR:         Jerome Guibert <jguibert@gmail.com>
# DESCRIPTION:    Redis Dockerfile
# TO_BUILD:       docker build --rm -t airdock/redis .
# SOURCE:         https://github.com/airdock-io/docker-redis

# Pull base image.
FROM airdock/base:latest

MAINTAINER Jerome Guibert <jguibert@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Install redis server
# Run in foreground, listen on all addresses
RUN echo "deb http://http.debian.net/debian wheezy-backports main contrib non-free" > /etc/apt/sources.list.d/backports.list && \
    apt-get update -qq && \
    apt-get install --no-install-recommends -y -t wheezy-backports redis-server && \
    chown -R redis:redis /etc/redis/ /data /var/log/redis && \
    sed -i 's/^\(daemonize\s*\)yes\s*$/\1no/g' /etc/redis/redis.conf && \
    sed -ri 's/^bind .*$/bind 0.0.0.0/g' /etc/redis/redis.conf && \
    sed -i 's/^\(dir .*\)$/# \1\ndir \/data/' /etc/redis/redis.conf && \
    sed -i 's/^\(logfile .*\)$/# \1/' /etc/redis/redis.conf && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /var/lib/apt/lists/* /tmp/* /var/tmp/* 

# Define mountable directories.
# data volume
VOLUME ["/data"]
# Configuration (redis.conf and sentinel.conf)
VOLUME ["/etc/redis"]

# Define working directory.
WORKDIR /data

# Expose ports.
EXPOSE 6379

# Define default command.
CMD ["gosu", "redis:redis", "/usr/bin/redis-server", "/etc/redis/redis.conf"]

