# VERSION 1.0
# AUTHOR:         Jerome Guibert <jguibert@gmail.com>
# DESCRIPTION:    Redis Dockerfile
# TO_BUILD:       docker build --rm -t airdock/redis .
# SOURCE:         https://github.com/airdock-io/docker-redis

# Pull base image.
FROM airdock/base:latest

MAINTAINER Jerome Guibert <jguibert@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN echo "deb http://http.debian.net/debian wheezy-backports main contrib non-free" > /etc/apt/sources.list.d/backports.list && \
    apt-get update -qq && \
    apt-get install --no-install-recommends -y -t wheezy-backports redis-server && \
    sed -i 's/^\(daemonize\s*\)yes\s*$/\1no/g' /etc/redis/redis.conf && \
    sed -i 's/^bind/#bind/g' /etc/redis/redis.conf && \
    sed -i 's/^\(bind .*\)$/# \1/' /etc/redis/redis.conf && \
    sed -i 's/^\(dir .*\)$/# \1\ndir \/data/' /etc/redis/redis.conf && \
    sed -i 's/^\(logfile .*\)$/# \1/' /etc/redis/redis.conf
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /var/lib/apt/lists/* /tmp/* /var/tmp/* 

# Define mountable directories.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data

# Expose ports.
EXPOSE 6379

# Define default command.
CMD ["/usr/bin/redis-server", "/etc/redis/redis.conf"]

